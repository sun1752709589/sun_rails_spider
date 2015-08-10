class Birt::Core::Mysql

  def self.client(data_source)
    @client ||=Mysql2::Client.new(
        host: data_source.host,
        port: data_source.port,
        username: data_source.username,
        password: data_source.password,
        database: data_source.database
    )
  end

  def self.query(data_source, query_text)
    client = client(data_source)
    results = client.query(query_text)
    yield(results) if block_given?
    results
  end
end