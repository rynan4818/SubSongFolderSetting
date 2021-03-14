#! ruby -Ks
# -*- mode:ruby; coding:shift_jis -*-
$KCODE='s'

#Set 'EXE_DIR' directly at runtime  直接実行時にEXE_DIRを設定する
EXE_DIR = (File.dirname(File.expand_path($0)).sub(/\/$/,'') + '/').gsub(/\//,'\\') unless defined?(EXE_DIR)

#Predefined Constants  設定済み定数
#EXE_DIR ****** Folder with EXE files[It ends with '\']  EXEファイルのあるディレクトリ[末尾は\]
#MAIN_RB ****** Main ruby script file name  メインのrubyスクリプトファイル名
#ERR_LOG ****** Error log file name  エラーログファイル名

require 'rexml/document'
require 'rubygems'
require 'json'
require 'vr/vruby'
require '_frm_SubSongFolderSetting'

SETTING_FILE = EXE_DIR + "setting.json"
DEFALT_XML = "C:\\Program Files (x86)\\Steam\\steamapps\\common\\Beat Saber\\UserData\\SongCore\\folders.xml"

class Form_main                                                     ##__BY_FDVR

  def self_created
    setting_load
    xml_load
    @index = 1
    xml_read
  end

  def setting_load
    @edit_xml.text = DEFALT_XML if File.exist?(DEFALT_XML)
    if File.exist?(SETTING_FILE)
      @setting = JSON.parse(File.read(SETTING_FILE))
      if @setting["xml"]
        @edit_xml.text = @setting["xml"]
      end
    end
  end

  def setting_save
    if File.exist?(SETTING_FILE)
      setting = JSON.parse(File.read(SETTING_FILE))
    else
      setting = {}
    end
    setting['xml'] = @edit_xml.text.strip
    File.open(SETTING_FILE,'w') do |file|
      JSON.pretty_generate(setting).each do |line|
        file.puts line
      end
    end
  end

  def xml_load
    if File.exist?(@edit_xml.text)
      @xml = REXML::Document.new(File.new(@edit_xml.text))
    else
      @xml = REXML::Document.new
      folders = REXML::Element.new('folders')
      @xml.add_element(folders)
      xml_empty_folder(folders)
    end
    @xml_size = 0
    @xml.elements.each("folders/folder") do |element|
      @xml_size += 1
    end
  end

  def xml_empty_folder(folders)
    folder = REXML::Element.new('folder')
    folders.add_element(folder)
    name = REXML::Element.new('Name')
    folder.add_element(name)
    path = REXML::Element.new('Path')
    folder.add_element(path)
    pack = REXML::Element.new('Pack')
    pack.add_text('0')
    folder.add_element(pack)
  end

  def xml_read
    @edit_index.text = @index.to_s
    @static_index_aria.caption = "1 - #{@xml_size}"
    element = @xml.elements["folders/folder[#{@index}]"]
    control_set(@edit_name,element,"Name")
    control_set(@edit_path,element,"Path")
    control_set(@edit_image,element,"ImagePath")
    if pack = element.elements["Pack"]
      case pack.text
      when "0"
        @radioBtn_custom.check(true)
        @radioBtn_wip.check(false)
        @radioBtn_new.check(false)
        radioBtn_custom_clicked
      when "1"
        @radioBtn_custom.check(false)
        @radioBtn_wip.check(true)
        @radioBtn_new.check(false)
        radioBtn_wip_clicked
      when "2"
        @radioBtn_custom.check(false)
        @radioBtn_wip.check(false)
        @radioBtn_new.check(true)
        radioBtn_new_clicked
      else
        @radioBtn_custom.check(true)
        @radioBtn_wip.check(false)
        @radioBtn_new.check(false)
        radioBtn_custom_clicked
      end
    else
      @radioBtn_custom.check(true)
      @radioBtn_wip.check(false)
      @radioBtn_new.check(false)
      radioBtn_custom_clicked
  end
  @checkBox_wip.check(false)
    if wip = element.elements["WIP"]
      @checkBox_wip.check(true) if wip.text =~ /true/i
    end
    @checkBox_zip.check(false)
    if zip = element.elements["CacheZIPs"]
      @checkBox_zip.check(true) if zip.text =~ /true/i
    end
  end

  def xml_add
    folders = @xml.elements["folders"]
    folder = REXML::Element.new('folder')
    folders.add_element(folder)
    name = REXML::Element.new('Name')
    folder.add_element(name)
    path = REXML::Element.new('Path')
    folder.add_element(path)
    pack = REXML::Element.new('Pack')
    pack.add_text('0')
    folder.add_element(pack)
  end
  
  def xml_set
    element = @xml.elements["folders/folder[#{@index}]"]
    element_set(element,"Name",@edit_name.text)
    element_set(element,"Path",@edit_path.text)
    if @radioBtn_custom.checked?
      pack = "0"
    elsif @radioBtn_wip.checked?
      pack = "1"
    elsif @radioBtn_new.checked?
      pack = "2"
      element_set(element,"ImagePath",@edit_image.text)
      if @checkBox_wip.checked?
        wip = "True"
      else
        wip = "False"
      end
      element_set(element,"WIP",wip)
    else
      pack = "0"
    end
    element_set(element,"Pack",pack)
    if @checkBox_zip.checked?
      zip = "True"
    else
      zip = "False"
    end
    element_set(element,"CacheZIPs",zip)
  end

  def control_set(control,element,tag)
    if element.elements[tag]
      control.text = element.elements[tag].text
    else
      control.text = ""
    end
  end

  def element_set(element,tag,value)
    unless element.elements[tag]
      new_tag = REXML::Element.new(tag)
      element.add_element(new_tag)
    end
    element.elements[tag].text = value
  end

  def button_prev_clicked
    if @index > 1
      xml_set
      @index -= 1
      xml_read
    end
  end

  def button_next_clicked
    if @index < @xml_size
      xml_set
      @index += 1
      xml_read
    end
  end

  def button_xml_clicked
    if File.exist?(@edit_xml.text.strip)
      folder = File.dirname(@edit_xml.text.strip) + "\\"
      file   = "folders.xml"
    else
      folder = nil
      file = nil
    end
    filename = SWin::CommonDialog::openFilename(self,[["xml File (*.xml)","*.xml"],["All File (*.*)","*.*"]],0x4,"Image file","*.xml",folder,file)
    return unless filename
    return unless File.exist?(filename)
    @edit_xml.text = filename
    xml_load
    @index = 1
    xml_read
    setting_save
  end

  def button_path_clicked
    if File.directory?(@edit_path.text.strip)
      defalut = @edit_path.text.strip
    else
      defalut = nil
    end
    folder = SWin::CommonDialog::selectDirectory(self,"Song Folder",defalut,1)
    return unless folder
    return unless File.exist?(folder)
    @edit_path.text = folder
  end

  def button_image_clicked
    if File.exist?(@edit_image.text.strip)
      folder = File.dirname(@edit_image.text.strip) + "\\"
      file   = File.basename(@edit_image.text.strip)
    else
      folder = nil
      file = nil
    end
    filename = SWin::CommonDialog::openFilename(self,[["Image File (*.png;*.jpg;*.jpeg;*.gif)","*.png;*.jpg;*.jpeg;*.gif"],["all file (*.*)","*.*"]],0x4,"Image file","*.jpg",folder,file)
    return unless filename                               #ファイルが選択されなかった場合、キャンセルされた場合は戻る
    @edit_image.text = filename
  end

  def button_cancel_clicked
    close
  end

  def button_save_clicked
    xml_set
    if messageBox("Save OK?", "Save xml file", 36) == 6
      #File.write('test.xml', @xml)
      File.open(@edit_xml.text.strip, 'w') do |file|
        @xml.write(file, -1)
      end      
    end
  end

  def button_delete_clicked
    elements = @xml.elements["folders/folder[#{@index}]"]
    ["Name","Path","Pack","ImagePath","WIP","CacheZIPs"].each do |tag|
      @xml.delete_element("folders/folder[#{@index}]/#{tag}")
    end
    @xml.delete_element("folders/folder[#{@index}]")
    @xml_size -= 1
    @index = @xml_size if @index > @xml_size
    if @xml_size < 1
      @xml_size = 1
      @index = 1
      folders = @xml.elements["folders"]
      xml_empty_folder(folders)
    end
    xml_read
  end

  def button_add_clicked
    @xml_size += 1
    @index = @xml_size
    xml_add
    xml_read
  end

  def radioBtn_custom_clicked
    @edit_image.readonly = true
    @checkBox_wip.style = 0x58000003
    @button_image.style = 0x58008000
    @static_image.style = 0x58000000
    @static_wip.style = 0x58000000
    refresh(true)
  end

  def radioBtn_wip_clicked
    @edit_image.readonly = true
    @checkBox_wip.style = 0x58000003
    @button_image.style = 0x58008000
    @static_image.style = 0x58000000
    @static_wip.style = 0x58000000
    refresh(true)
  end

  def radioBtn_new_clicked
    @edit_image.readonly = false
    @checkBox_wip.style = 0x50000003
    @button_image.style = 0x50000000
    @static_image.style = 0x50000000
    @static_wip.style = 0x50000000
    refresh(true)
  end
end                                                                 ##__BY_FDVR

VRLocalScreen.start Form_main
