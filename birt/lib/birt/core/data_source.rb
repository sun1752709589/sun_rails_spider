class Birt::Core::DataSource

  attr_accessor :name
  attr_accessor :host
  attr_accessor :port
  attr_accessor :username
  attr_accessor :password
  attr_accessor :database

  def initialize(xml_element)
    if xml_element
      self.name = xml_element.attribute(:name).value
      self.host = xml_element.get_elements("property[@name='odaURL']")[0].text
      self.username = xml_element.get_elements("property[@name='odaUser']")[0].text
      self.password = Base64.decode64 xml_element.get_elements("encrypted-property[@name='odaPassword']")[0].text
    end
    yield(self) if block_given?
  end

  def host=(host)
    host_port = host.gsub('jdbc:mysql://', '').split(':')
    port_database = host_port[1].split('/')
    @host = host_port[0]
    @port = port_database[0]
    @database = port_database[1]
  end
end