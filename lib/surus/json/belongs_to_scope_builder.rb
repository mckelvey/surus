module Surus
  module JSON
    class BelongsToScopeBuilder < AssociationScopeBuilder
      def scope
        s = association
          .klass
          .where("#{primary_table}.#{primary_key}=#{association_table}.#{association_foreign_key}")
        s = s.instance_eval(&association.scope) if association.scope
        s
      end

      def primary_table
        connection.quote_table_name association.klass.table_name
      end

      def primary_key
        quote_column_name association.active_record_primary_key
      end

      def association_table
        outside_class.quoted_table_name
      end

      def association_foreign_key
        quote_column_name association.foreign_key
      end

    end
  end
end
