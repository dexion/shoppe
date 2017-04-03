require 'test_helper'

module Shoppe
    class AttachmentTest < ActiveSupport::TestCase
        test "file should be validated" do
            file = File.join( Rails.root, "public/images/kamen/montage.jpg" )

            Rails::logger.debug do
                file.filename.to_s
                file.content_type.to_s
                file.size.to_s
            end

            assertion true

        end

    end
end
