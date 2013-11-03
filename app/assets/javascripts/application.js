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
//= require_tree .
//= require turbolinks
var editor = null;
function prettifyEditor() {
    editor = ace.edit("editor");
    editor.setTheme("ace/theme/github");
    var syntax = $('#data').attr("syntax");
    if (!syntax) {
      	syntax = 'java';
    }
    editor.getSession().setMode("ace/mode/"+syntax);
}

function setHeight() {

    var newHeight = editor.getSession().getScreenLength() * editor.renderer.lineHeight + editor.renderer.scrollBar.getWidth();
    console.log("height: " + newHeight);
    $('#editor').height(newHeight.toString() + "px");
    editor.resize();
    /*$("#editor").css("width", $("#editor-wrapper").width());*/
    editor.resize();
    /*$("#editor-wrapper").css("height", (newHeight + 40) + "px");*/
}

function  render(){
    console.log("render called");
    prettifyEditor();
    setHeight();
}

$(document).ready(render);
$(document).on("page:load", render);
$(document).on("page:restore", render);
$(document).on("page:change", render);
