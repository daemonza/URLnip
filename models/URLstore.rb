#URLstore model
# Our url's get's stored in this model
# Coded by Werner Gillmer <werner.gillmer@gmail.com>
require 'mongo_mapper'

#MongoMapper.connection = Mongo::Connection.new('127.0.0.1')
#MongoMapper.database = 'ARGH'


class URLstore
  include MongoMapper::Document
    
  key :url_key, String, :required => true
  key :url, String, :required => true

end

