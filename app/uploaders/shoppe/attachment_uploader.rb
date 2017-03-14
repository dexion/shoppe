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

    def resize_to_fit(width, height, combine_options: {})
        manipulate! do |img|
            img.combine_options do |cmd|
                cmd.resize "#{width}x#{height}"
                append_combine_options cmd, combine_options
            end
            img = yield(img) if block_given?
            img
        end
    end

    # Create different versions of your uploaded files:
    version :thumb, if: :image? do
        process resize_to_fit: [500, 500,{fuzz: "0%"}]
    end
end
