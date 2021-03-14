##__BEGIN_OF_FORMDESIGNER__
## CAUTION!! ## This code was automagically ;-) created by FormDesigner.
## NEVER modify manualy -- otherwise, you'll have a terrible experience.

require 'vr/vruby'
require 'vr/vrcontrol'

class Form_main < VRForm

  def construct
    self.caption = 'SubSongFolderSetting'
    self.move(526,297,682,455)
    addControl(VRButton,'button_add',"Additional",312,104,120,24)
    addControl(VRButton,'button_cancel',"Close",448,352,88,32)
    addControl(VRButton,'button_delete',"DELETE",472,104,104,24)
    addControl(VRButton,'button_image',"Open",560,272,64,24)
    addControl(VRButton,'button_next',"Next",192,104,64,24)
    addControl(VRButton,'button_path',"Open",560,192,64,24)
    addControl(VRButton,'button_prev',"Prev",24,104,80,24)
    addControl(VRButton,'button_save',"Save",552,352,80,32)
    addControl(VRButton,'button_xml',"Open",560,48,64,24)
    addControl(VRCheckbox,'checkBox_wip',"WIP and only be playable in practicemode",112,320,312,24)
    addControl(VRCheckbox,'checkBox_zip',"zip the archives in this folder and show",112,360,304,24)
    addControl(VREdit,'edit_image',"",112,272,448,24)
    addControl(VREdit,'edit_index',"",112,104,72,24)
    addControl(VREdit,'edit_name',"",112,152,448,24)
    addControl(VREdit,'edit_path',"",112,192,448,24)
    addControl(VREdit,'edit_xml',"",176,48,384,24)
    addControl(VRRadiobutton,'radioBtn_custom',"0:Custom Levels",112,232,144,24)
    addControl(VRRadiobutton,'radioBtn_new',"2:New Pack",400,232,112,24)
    addControl(VRRadiobutton,'radioBtn_wip',"1:Wip Levels",272,232,112,24)
    addControl(VRStatic,'static1',"Caution! Use ASCII characters for the Path and Name",144,8,408,24)
    addControl(VRStatic,'static_image',"Image Path",24,272,88,24)
    addControl(VRStatic,'static_index_aria',"",112,80,72,24)
    addControl(VRStatic,'static_name',"Name",24,152,88,24)
    addControl(VRStatic,'static_pack',"Pack",24,232,88,24)
    addControl(VRStatic,'static_path',"Path",24,192,88,24)
    addControl(VRStatic,'static_wip',"WIP",24,320,80,24)
    addControl(VRStatic,'static_xml',"SongCore folders.xml",24,48,152,24)
    addControl(VRStatic,'static_zip',"CacheZIPs",24,360,88,24)
  end 

end

##__END_OF_FORMDESIGNER__
