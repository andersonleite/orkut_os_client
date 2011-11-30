module Orkut
  class Version

    def self.major
      0
    end

    def self.minor
      1
    end

    def self.patch
      0
    end

    def self.pre
      nil
    end

    def self.to_s
      [major, minor, patch, pre].compact.join('.')
    end

  end
end