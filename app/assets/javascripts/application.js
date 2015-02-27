// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks

var editor = null;
function prettifyEditor() {
    editor = ace.edit("editor");
    editor.setTheme("ace/theme/github");
    var syntax = $('#paste_encoding').attr("syntax");
    if (!syntax) {
      syntax = 'java';
    }
    editor.getSession().setMode("ace/mode/"+syntax);

    $('#paste_encoding').change(function(){
      var value = $('#paste_encoding option:selected').attr('value');
      var mode = "ace/mode/"+value;
      editor.getSession().setMode(mode);
      console.log("updating mode");
    });
}

function setHeight() {
    var newHeight = editor.getSession().getScreenLength() * editor.renderer.lineHeight + editor.renderer.scrollBar.getWidth();
    var minHeight = 160;
    var maxHeight = $(window).height() - 300;

    if (newHeight < maxHeight){
      newHeight = maxHeight;
    }
    $('#editor').height(newHeight.toString() + "px");
    editor.resize();
}

function update_text_area() {
  var textarea = $('textarea[name="paste[body]"]').hide();
  if (textarea) {
    editor.getSession().setValue(textarea.val());
    editor.getSession().on('change', function(){
      textarea.val(editor.getSession().getValue());
    });
  }
}

function render(){
    prettifyEditor();
    update_text_area();
    setHeight();
    editor.getSession().on('change', function(){
      setHeight();
    });
}

$(document).ready(render);
$(document).on("page:load", render);
$(document).on("page:restore", render);
$(document).on("page:change", render);
$(window).resize(setHeight);
