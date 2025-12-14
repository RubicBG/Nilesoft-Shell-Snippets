// Author: Rubic / RubicBG
// https://github.com/RubicBG/Nilesoft-Shell-Snippets/

menu(title='Run with priority' where=sel.file.ext=='.exe' or path.file.ext(sel.lnktarget)=='.exe' image=\uE257) {
	// Temporary priority settings (for this session only)
	//> https://www.tenforums.com/tutorials/89548-set-cpu-process-priority-applications-windows-10-a.html
	$executable = if(sel.file.ext=='.lnk', sel.lnktarget, sel.path)
	item(image=inherit title='Realtime' tip='Highest priority - Use with extreme caution! Can freeze system if process hangs'
		window=0 admin cmd-line=`/c start "" /Realtime @quote(executable)`)
	item(image=inherit title='High' tip='High priority - Good for performance-critical applications'
		window=0 cmd-line=`/c start "" /High @quote(executable)`)
	item(image=inherit title='Above normal' tip='Slightly higher priority - Balanced performance boost'
		window=0 cmd-line=`/c start "" /AboveNormal @quote(executable)`)
	item(image=inherit title='Normal' keys='default' tip='Standard priority - Windows default behavior'
		window=0 cmd-line=`/c start "" /Normal @quote(executable)`)
	item(image=inherit title='Below normal' tip='Lower priority - Runs in background, less CPU usage'
		window=0 cmd-line=`/c start "" /BelowNormal @quote(executable)`)
	item(image=inherit title='Low' tip='Lowest priority - Minimal CPU usage, runs when system is idle'
		window=0 cmd-line=`/c start "" /Low @quote(executable)`)
	separator()
	$reg_path_main = 'HKLM\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Image File Execution Options'
	$reg_path_exem = '@reg_path_main\@path.file.name(executable)'
	$reg_path_perf = '@reg_path_exem\PerfOptions'
	$cpc = null
	menu(title={ cpc = reg.get('@reg_path_perf', 'CpuPriorityClass') } + 'Set permanent priority' expanded=1) {
		$is_created_by_ns = len(reg.keys(reg_path_exem))==1 and reg.exists('@reg_path_perf')
		item(image=[[\uE170, image.color1],[if(cpc==3, \uE16E), image.color2]] title='High' tip='Permanently set high priority - Requires admin rights'
			window=0 admin cmd-line=`/c reg add "@reg_path_perf" /v CpuPriorityClass /t REG_DWORD /d 3 /f`)
		item(image=[[\uE170, image.color1],[if(cpc==6, \uE16E), image.color2]] title='Above normal' tip='Permanently set above normal priority - Good for games and multimedia'
			window=0 admin cmd-line=`/c reg add "@reg_path_perf" /v CpuPriorityClass /t REG_DWORD /d 6 /f`)
		item(image=[[\uE170, image.color1],[if(cpc==2 or str.null(cpc), \uE16E), image.color2]] title='Normal' keys='reset' vis=if(!is_created_by_ns, 'disabled') tip='Remove permanent priority setting - Return to system default'
			window=0 admin cmd-line=`/c reg delete "@if(is_created_by_ns, reg_path_exem, reg_path_perf)" /f`)
		item(image=[[\uE170, image.color1],[if(cpc==5, \uE16E), image.color2]] title='Below normal' tip='Permanently set below normal priority - Good for background services'
			window=0 admin cmd-line=`/c reg add "@reg_path_perf" /v CpuPriorityClass /t REG_DWORD /d 5 /f`)
		item(image=[[\uE170, image.color1],[if(cpc==1, \uE16E), image.color2]] title='Low' tip='Permanently set low priority - For non-critical background tasks'
			window=0 admin cmd-line=`/c reg add "@reg_path_perf" /v CpuPriorityClass /t REG_DWORD /d 1 /f`) }
}