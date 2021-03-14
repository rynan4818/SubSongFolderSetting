#! ruby -Ks
# -*- mode:ruby; coding:shift_jis -*-
$KCODE='s'


lib = <<EOS
#! ruby -Ks
# -*- mode:ruby; coding:shift_jis -*-
$KCODE='s'

#Set 'EXE_DIR' directly at runtime  ���ڎ��s����EXE_DIR��ݒ肷��
EXE_DIR = (File.dirname(File.expand_path($0)).sub(/\\/$/,'') + '/').gsub(/\\//,'\\\\') unless defined?(EXE_DIR)

#Available Libraries  �g�p�\���C�u����
#require 'jcode'
#require 'nkf'
#require 'csv'
#require 'fileutils'
#require 'pp'
#require 'date'
#require 'time'
#require 'base64'
#require 'win32ole'
#require 'Win32API'
#require 'vr/vruby'
#require 'vr/vrcontrol'
#require 'vr/vrcomctl'
#require 'vr/clipboard'
#require 'vr/vrddrop.rb'
#require 'json'

#Predefined Constants  �ݒ�ςݒ萔
#EXE_DIR ****** Folder with EXE files[It ends with '\\']  EXE�t�@�C���̂���f�B���N�g��[������\\]
#MAIN_RB ****** Main ruby script file name  ���C����ruby�X�N���v�g�t�@�C����
#ERR_LOG ****** Error log file name  �G���[���O�t�@�C����






#The condition is positive when this split is executed directly.
#���̃X�v���N�g�𒼐ڎ��s���ɏ��������ɂȂ�B
if (defined?(ExerbRuntime) ? EXE_DIR + MAIN_RB : $0) == __FILE__
  require 'win32ole'
  wsh = WIN32OLE.new('WScript.Shell')
  wsh.Popup("Program execution ended.", 0, "Information", 0 + 64 + 0x40000)
end

EOS

EXE_DIR   = File.dirname(ExerbRuntime.filepath) + '\\'
MAIN_RB   = File.basename(ExerbRuntime.filepath,'.*') + '.rb'
ERR_LOG   = File.basename(ExerbRuntime.filepath,'.*') + '_err.txt'
core_ruby = EXE_DIR + MAIN_RB
err_log_file = EXE_DIR + ERR_LOG
$LOAD_PATH.push(EXE_DIR.gsub(/\\/,'/').sub(/\/$/,'')) if $Exerb

if File.exist?(core_ruby)
  if File.exist?(err_log_file)
    File.delete(err_log_file)
  end
  begin
    require core_ruby if $Exerb
  rescue Exception => e
    unless e.message == 'exit'
      require 'win32ole'
      wsh = WIN32OLE.new('WScript.Shell')
      errmsg = "******** Terminated with error ********\n\n"
      errmsg += "******** Error message ********\n" + e.inspect + "\r\n******** Backtrace ********\r\n"
      e.backtrace.each{|a| errmsg += a + "\n"}
      wsh.Popup((errmsg + "\nError log file = #{err_log_file}").gsub(/\n/,"\r\n"), 0, "ERROR", 0 + 64 + 0x40000)
      File.open(err_log_file,'w') do |f|
        errmsg.each do |a|
          f.puts a
        end
      end
    end
  end
else
  require 'win32ole'
  wsh = WIN32OLE.new('WScript.Shell')
  wsh.Popup("There is no '#{core_ruby}', I will create it.", 0, "Information", 0 + 64 + 0x40000)
  File.open(core_ruby,'w') do |f|
    lib.each do |a|
      f.puts a
    end
  end
end
