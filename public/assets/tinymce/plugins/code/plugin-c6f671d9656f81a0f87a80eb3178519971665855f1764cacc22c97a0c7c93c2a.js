!function(){"use strict";var t=tinymce.util.Tools.resolve("tinymce.PluginManager"),n=tinymce.util.Tools.resolve("tinymce.dom.DOMUtils"),e=function(t){return t.getParam("code_dialog_width",600)},o=function(t){return t.getParam("code_dialog_height",Math.min(n.DOM.getViewPort().h-200,500))},i=function(t,n){t.focus(),t.undoManager.transact(function(){t.setContent(n)}),t.selection.setCursorLocation(),t.nodeChanged()},c=function(t){return t.getContent({source_view:!0})},d=function(t){var n=e(t),d=o(t);t.windowManager.open({title:"Source code",body:{type:"textbox",name:"code",multiline:!0,minWidth:n,minHeight:d,spellcheck:!1,style:"direction: ltr; text-align: left"},onSubmit:function(n){i(t,n.data.code)}}).find("#code").value(c(t))},u=function(t){t.addCommand("mceCodeEditor",function(){d(t)})},a=function(t){t.addButton("code",{icon:"code",tooltip:"Source code",onclick:function(){d(t)}}),t.addMenuItem("code",{icon:"code",text:"Source code",onclick:function(){d(t)}})};t.add("code",function(t){return u(t),a(t),{}})}();