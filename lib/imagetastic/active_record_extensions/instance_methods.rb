module Imagetastic
  module ActiveRecordExtensions
    module InstanceMethods
      
      def attachment_for(attribute)
        attachments[attribute] ||= Attachment.new(app_for(attribute))
      end
      
      private
      
      def attachments
        @attachments ||= {}
      end
      
      def app_for(attribute)
        self.class.attachment_app_mappings[attribute]
      end
      
      def save_attached_files
        attachments.each do |attribute, attachment|
          attachment.save
        end
      end
      
      def destroy_attached_files
        attachments.each do |attribute, attachment|
          attachment.destroy
        end
      end
      
    end
  end
end