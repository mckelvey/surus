module Surus
  module JSON
    class BelongsToScopeBuilder < AssociationScopeBuilder
      def scope
        logger = Rails.logger
        logger.info "association table"
        logger.info association_table
        
        s = association
          .klass
          .where("#{quote_column_name association.active_record_primary_key}=#{quote_column_name association.foreign_key}")
        s = s.instance_eval(&association.scope) if association.scope
        s
      end

      def join_table
        connection.quote_table_name association.join_table
      end

      def association_foreign_key
        connection.quote_column_name association.association_foreign_key
      end

      def foreign_key
        connection.quote_column_name association.foreign_key
      end

      def association_table
        connection.quote_table_name association.klass.table_name
      end

      def association_primary_key
        connection.quote_column_name association.association_primary_key
      end

    end
  end
end
