/**
 * Copyright (c) Tiny Technologies, Inc. All rights reserved.
 * Licensed under the LGPL or a commercial license.
 * For LGPL see License.txt in the project root for license information.
 * For commercial licenses see https://www.tiny.cloud/
 *
 * Version: 5.6.2 (2020-12-08)
 */
!function(){"use strict";var e,t=tinymce.util.Tools.resolve("tinymce.PluginManager"),a=(e=undefined,function(t){return e===t}),r=tinymce.util.Tools.resolve("tinymce.util.Delay"),n=tinymce.util.Tools.resolve("tinymce.util.LocalStorage"),o=tinymce.util.Tools.resolve("tinymce.util.Tools"),i=function(t,e){var r=t||e,n=/^(\d+)([ms]?)$/.exec(""+r);return(n[2]?{s:1e3,m:6e4}[n[2]]:1)*parseInt(r,10)},u=function(t){var e=document.location;return t.getParam("autosave_prefix","tinymce-autosave-{path}{query}{hash}-{id}-").replace(/{path}/g,e.pathname).replace(/{query}/g,e.search).replace(/{hash}/g,e.hash).replace(/{id}/g,t.id)},s=function(t,e){if(a(e))return t.dom.isEmpty(t.getBody());var r=o.trim(e);if(""===r)return!0;var n=(new DOMParser).parseFromString(r,"text/html");return t.dom.isEmpty(n)},f=function(t){var e=parseInt(n.getItem(u(t)+"time"),10)||0;return!((new Date).getTime()-e>i(t.getParam("autosave_retention"),"20m"))||(c(t,!1),!1)},c=function(t,e){var r=u(t);n.removeItem(r+"draft"),n.removeItem(r+"time"),!1!==e&&t.fire("RemoveDraft")},m=function(t){var e=u(t);!s(t)&&t.isDirty()&&(n.setItem(e+"draft",t.getContent({format:"raw",no_events:!0})),n.setItem(e+"time",(new Date).getTime().toString()),t.fire("StoreDraft"))},l=function(t){var e=u(t);f(t)&&(t.setContent(n.getItem(e+"draft"),{format:"raw"}),t.fire("RestoreDraft"))},v=function(t){var e=i(t.getParam("autosave_interval"),"30s");r.setEditorInterval(t,function(){m(t)},e)},d=function(t){t.undoManager.transact(function(){l(t),c(t)}),t.focus()},g=tinymce.util.Tools.resolve("tinymce.EditorManager"),y=function(r){return function(t){t.setDisabled(!f(r));var e=function(){return t.setDisabled(!f(r))};return r.on("StoreDraft RestoreDraft RemoveDraft",e),function(){return r.off("StoreDraft RestoreDraft RemoveDraft",e)}}};t.add("autosave",function(t){var e,r;return t.editorManager.on("BeforeUnload",function(t){var e;o.each(g.get(),function(t){t.plugins.autosave&&t.plugins.autosave.storeDraft(),!e&&t.isDirty()&&t.getParam("autosave_ask_before_unload",!0)&&(e=t.translate("You have unsaved changes are you sure you want to navigate away?"))}),e&&(t.preventDefault(),t.returnValue=e)}),v(e=t),e.ui.registry.addButton("restoredraft",{tooltip:"Restore last draft",icon:"restore-draft",onAction:function(){d(e)},onSetup:y(e)}),e.ui.registry.addMenuItem("restoredraft",{text:"Restore last draft",icon:"restore-draft",onAction:function(){d(e)},onSetup:y(e)}),t.on("init",function(){t.getParam("autosave_restore_when_empty",!1)&&t.dom.isEmpty(t.getBody())&&l(t)}),r=t,{hasDraft:function(){return f(r)},storeDraft:function(){return m(r)},restoreDraft:function(){return l(r)},removeDraft:function(t){return c(r,t)},isEmpty:function(t){return s(r,t)}}})}();