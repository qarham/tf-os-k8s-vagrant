#! /usr/bin/env ruby
# -*- mode: ruby -*-
# vi: set ft=ruby :

require 'ipaddr'
require 'yaml'

class Config
    def initialize(topo)
        @config     = YAML.load_file(topo)
        @ipaddrmask = nil
        @demo       = File.basename(File.dirname(caller_locations.first.path))

        @config['environment'].each do |k, v|
            ENV[k] = v
        end
    end

    def version
        "#{@demo} v1.0"
    end

    def get_next_addr
        x = nil
        loop do
            if @ipaddrmask.nil? then
                @ipaddrmask = next_addr_block
                raise EOFError if @ipaddrmask.nil?
            end

            begin
                x = @ipaddrmask.next
            rescue StopIteration
                @ipaddrmask = nil
                redo
            else
                break
            end
        end
        return x.to_s
    end

    def get_default_gw
        get_val('default-gw')
    end

    def get_dns_entries
        get_val('dns')
    end

    private

    def get_val(key)
        if @config.key?(key) then
            return @config[key]
        end
        return nil
    end

    def next_addr_block
        x = @config['management-address-pool'].shift
        if not x.nil? then
            return IPAddr.new(x).to_range.each
        end
        return nil
    end
end
