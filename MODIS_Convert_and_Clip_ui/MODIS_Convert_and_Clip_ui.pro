pro MODIS_Convert_and_Clip_extensions_init
  compile_opt idl2, hidden
  ; Get ENVI session
  e = ENVI(/CURRENT)
  ; Add the extension to a subfolder
  e.AddExtension, 'MODIS_Convert_and_Clip', 'MODIS_Convert_and_Clip_ui', PATH=''
end
; ENVI Extension code. Called when the toolbox item is chosen.
pro MODIS_Convert_and_Clip_ui
  compile_opt idl2, hidden
  ; General error handler
  CATCH, err
  if (err ne 0) then begin
    CATCH, /CANCEL
    if OBJ_VALID(e) then $
      e.ReportError, 'ERROR:' + !error_state.msg
    MESSAGE, /RESET
    return
  endif
  ;Get ENVI session
  e = ENVI(/CURRENT)
  Task = ENVITask('MODIS_Convert_and_Clip')
  ok = e.UI.SelectTaskParameters(Task)
  ;If user cancelled then just return
  if ok ne 'OK' then return
  ;Execute the task
  Task.Execute
  msg = DIALOG_MESSAGE("Success!!!")
end