# frozen_string_literal: true

module MQ
  module REST
    module Admin
      # @return [Array<String>] valid top-level keys in mapping override data
      VALID_TOP_LEVEL_KEYS = %w[commands qualifiers].freeze

      # @return [Array<String>] valid sub-keys within qualifier override entries
      VALID_QUALIFIER_SUB_KEYS = %w[
        request_key_map request_value_map request_key_value_map
        response_key_map response_value_map
      ].freeze

      # @return [Symbol] merge mode for mapping overrides
      MAPPING_OVERRIDE_MERGE = :merge

      # @return [Symbol] replace mode for mapping overrides
      MAPPING_OVERRIDE_REPLACE = :replace

      # Validation and merging of mapping override data.
      #
      # Supports two override modes: merge (add/update individual entries)
      # and replace (substitute the entire mapping data set).
      module MappingMerge
        module_function

        # Validate the structure of mapping override data.
        #
        # @param overrides [Hash{String => Object}] the override data to validate
        # @return [void]
        # @raise [ArgumentError] if top-level or sub-keys are invalid
        # @raise [TypeError] if values have unexpected types
        def validate_mapping_overrides(overrides)
          validate_top_level_keys(overrides)
          validate_commands_section(overrides['commands'])
          validate_qualifiers_section(overrides['qualifiers'])
        end

        # Deep merge override data into a base mapping data set.
        #
        # @param base [Hash{String => Object}] the base mapping data
        # @param overrides [Hash{String => Object}] the override data to merge
        # @return [Hash{String => Object}] the merged mapping data (new copy)
        def merge_mapping_data(base, overrides)
          merged = deep_copy(base)
          merge_commands(merged, overrides['commands'])
          merge_qualifiers(merged, overrides['qualifiers'])
          merged
        end

        # Create a new mapping data set from overrides only.
        #
        # @param overrides [Hash{String => Object}] the replacement mapping data
        # @return [Hash{String => Object}] a deep copy of the override data
        def replace_mapping_data(overrides)
          deep_copy(overrides)
        end

        # Validate that overrides cover all keys present in the base mapping.
        #
        # Used in replace mode to ensure the override data is complete.
        #
        # @param base [Hash{String => Object}] the base mapping data
        # @param overrides [Hash{String => Object}] the replacement data
        # @return [void]
        # @raise [ArgumentError] if the override data is incomplete
        def validate_mapping_overrides_complete(base, overrides)
          missing_parts = []

          base_commands = base['commands']
          override_commands = overrides['commands']
          if base_commands.is_a?(Hash)
            override_commands_map = override_commands.is_a?(Hash) ? override_commands : {}
            missing = (base_commands.keys - override_commands_map.keys).sort
            missing.each { |key| missing_parts << "commands: #{key}" }
          end

          base_qualifiers = base['qualifiers']
          override_qualifiers = overrides['qualifiers']
          if base_qualifiers.is_a?(Hash)
            override_qualifiers_map = override_qualifiers.is_a?(Hash) ? override_qualifiers : {}
            missing = (base_qualifiers.keys - override_qualifiers_map.keys).sort
            missing.each { |key| missing_parts << "qualifiers: #{key}" }
          end

          return if missing_parts.empty?

          detail = missing_parts.map { |e| "  #{e}" }.join("\n")
          raise ArgumentError, "mapping_overrides is incomplete for REPLACE mode. Missing entries:\n#{detail}"
        end

        # --- Private helpers ---

        def validate_top_level_keys(overrides)
          overrides.each_key do |key|
            next if VALID_TOP_LEVEL_KEYS.include?(key)

            raise ArgumentError,
                  "Invalid top-level key in mapping_overrides: #{key.inspect} " \
                  "(expected subset of #{VALID_TOP_LEVEL_KEYS.sort})"
          end
        end

        def validate_commands_section(commands)
          return if commands.nil?

          raise TypeError, "mapping_overrides['commands'] must be a Hash" unless commands.is_a?(Hash)

          commands.each do |key, entry|
            raise TypeError, "mapping_overrides['commands'][#{key.inspect}] must be a Hash" unless entry.is_a?(Hash)
          end
        end

        def validate_qualifiers_section(qualifiers)
          return if qualifiers.nil?

          raise TypeError, "mapping_overrides['qualifiers'] must be a Hash" unless qualifiers.is_a?(Hash)

          qualifiers.each do |key, entry|
            raise TypeError, "mapping_overrides['qualifiers'][#{key.inspect}] must be a Hash" unless entry.is_a?(Hash)

            validate_qualifier_entry(key, entry)
          end
        end

        def validate_qualifier_entry(qualifier_key, entry)
          entry.each_key do |sub_key|
            next if VALID_QUALIFIER_SUB_KEYS.include?(sub_key)

            raise ArgumentError,
                  "Invalid sub-key #{sub_key.inspect} in " \
                  "mapping_overrides['qualifiers'][#{qualifier_key.inspect}] " \
                  "(expected subset of #{VALID_QUALIFIER_SUB_KEYS.sort})"
          end
          entry.each do |sub_key, sub_value|
            unless sub_value.is_a?(Hash)
              raise TypeError,
                    "mapping_overrides['qualifiers'][#{qualifier_key.inspect}][#{sub_key.inspect}] must be a Hash"
            end
          end
        end

        def merge_commands(merged, override_commands)
          return unless override_commands.is_a?(Hash)

          merged['commands'] ||= {}
          base_commands = merged['commands']
          override_commands.each do |key, entry|
            next unless entry.is_a?(Hash)

            existing = base_commands[key]
            if existing.is_a?(Hash)
              existing.merge!(entry)
            else
              base_commands[key] = entry.dup
            end
          end
        end

        def merge_qualifiers(merged, override_qualifiers)
          return unless override_qualifiers.is_a?(Hash)

          merged['qualifiers'] ||= {}
          base_qualifiers = merged['qualifiers']
          override_qualifiers.each do |key, entry|
            next unless entry.is_a?(Hash)

            merge_single_qualifier(base_qualifiers, key, entry)
          end
        end

        def merge_single_qualifier(base_qualifiers, key, entry)
          existing = base_qualifiers[key]
          unless existing.is_a?(Hash)
            base_qualifiers[key] = entry.dup
            return
          end

          entry.each do |sub_key, sub_value|
            next unless sub_value.is_a?(Hash)

            existing_sub = existing[sub_key]
            if existing_sub.is_a?(Hash)
              existing_sub.merge!(sub_value)
            else
              existing[sub_key] = sub_value.dup
            end
          end
        end

        def deep_copy(obj)
          Marshal.load(Marshal.dump(obj))
        end

        private_class_method :validate_top_level_keys, :validate_commands_section,
                             :validate_qualifiers_section, :validate_qualifier_entry,
                             :merge_commands, :merge_qualifiers, :merge_single_qualifier,
                             :deep_copy
      end
    end
  end
end
