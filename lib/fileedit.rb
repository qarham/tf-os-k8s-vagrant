#!/usr/bin/env ruby

require 'tempfile'
require 'fileutils'

def file_edit(filename, regexp, replacement)
  tempdir = File.dirname(filename)
  temppfx = File.basename(filename)
  tempfile =
    begin
      Tempfile.new(temppfx, tempdir)
    rescue
      Tempfile.new(temppfx)
    end

  stat = File.stat(filename)
  FileUtils.chown stat.uid, stat.gid, tempfile.path
  FileUtils.chmod stat.mode, tempfile.path
  
  File.open(filename).each do |line|
    tempfile.puts line.gsub(regexp, replacement)
  end
  tempfile.close

  FileUtils.mv tempfile.path, filename
end

def test_file_edit(a)
    (str, regexp, repl, newstr) = a
    tf = Tempfile.new('foo')
    tf.write(str)
    tf.close
    ret = false

    file_edit(tf.path, regexp, repl)

    File.open(tf.path, 'r').each do |l|
        ret = !(l =~ /#{newstr}/).nil?
        break
    end
    tf.close
    tf.unlink

    ret
end

if __FILE__ == $0 then
    #
    # usage
    #
    f = '/tmp/foo'
    File.open(f, 'w') do |fd|
        fd.puts('123 fooo bar')
    end
    file_edit(f, /foo/, "baz")
    File.unlink(f)

    #
    tests = [
        [ "replace, match",
          "123 foo xyz", /foo/, 'baz', '123 baz xyz', true
        ],
        [ "no replace, match",
          '456 bar abc', /foo/, 'boo', '456 bar abc', true
        ],
        [ "replace, fail match",
          "123 foo xyz", /foo/, 'baz', 'baz baz xyz', false
        ],
        [ "no replace, fail match",
          '456 bar abc', /foo/, 'boo', 'baz bar abc', false
        ],
    ]

    tests.each do |a|
        tname = a.shift
        trslt = a.pop
        puts("#{tname}\t%s" %
             (test_file_edit(a) == trslt ? "OK" : "NOT OK"))
    end
end
