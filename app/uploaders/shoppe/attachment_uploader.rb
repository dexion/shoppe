# encoding: utf-8

class Shoppe::AttachmentUploader < CarrierWave::Uploader::Base
    include CarrierWave::MiniMagick

    # Where should files be stored?
    def store_dir
        "attachment/#{model.id}"
    end

    # Returns true if the file is an image
    def image?(_new_file)
        file.content_type.include? 'image'
    end

    # Returns true if the file is not an image
    def not_image?(_new_file)
        !file.content_type.include? 'image'
    end

    def mogrify(width,height,options = {})
        manipulate! do |img|
            img.format("jpg") do |c|
                c.fuzz        "0%"
                c.trim
                c.rotate      "#{options[:rotate]}" if options.has_key?(:rotate)
                c.resize    "#{width}x#{height}"
                c.push        '+profile'
                c.+           "!xmp,*"
                c.profile     "../../lib/color_profiles/sRGB_v4_ICC_preference_displayclass.icc"
                c.colorspace  "sRGB"
            end
            img
        end
    end
    # Create different versions of your uploaded files:
    version :thumb, if: :image? do
        process mogrify: [500, 500]
    end
end
