## Исследование скорости работы crmsh 

### Stacktrace
#### crm resource param rsc show test

Рассмотрим стректрейс команды 
`crm resource param rsc show test`

(на самом деле из интерактивного окружения, чтобы опустить загрузку python's VM, об этом в разделе Python's VM, 
`crm(live)# resource param rsc show test`)

```
crm(live)# resource param rsc show test
( call ) |  |  |  |  |  |  incr_lineno
( call ) |  |  |  |  |  run
( call ) |  |  |  |  |  |  split
( call ) |  |  |  |  |  |  |  next
( call ) |  |  |  |  |  |  |  |  get_token
( call ) |  |  |  |  |  |  |  |  |  read_token
( call ) |  |  |  |  |  |  |  next
( call ) |  |  |  |  |  |  |  |  get_token
( call ) |  |  |  |  |  |  |  |  |  read_token
( call ) |  |  |  |  |  |  |  next
( call ) |  |  |  |  |  |  |  |  get_token
( call ) |  |  |  |  |  |  |  |  |  read_token
( call ) |  |  |  |  |  |  |  next
( call ) |  |  |  |  |  |  |  |  get_token
( call ) |  |  |  |  |  |  |  |  |  read_token
( call ) |  |  |  |  |  |  |  next
( call ) |  |  |  |  |  |  |  |  get_token
( call ) |  |  |  |  |  |  |  |  |  read_token
( call ) |  |  |  |  |  |  |  next
( call ) |  |  |  |  |  |  |  |  get_token
( call ) |  |  |  |  |  |  |  |  |  read_token
( call ) |  |  |  |  |  |  current_level
( call ) |  |  |  |  |  |  get_child
( call ) |  |  |  |  |  |  |  fuzzy_get
( call ) |  |  |  |  |  |  enter_level
( call ) |  |  |  |  |  |  |  requires
( call ) |  |  |  |  |  |  |  |  is_program
( call ) |  |  |  |  |  |  |  |  |  getenv
( call ) |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  join
( call ) |  |  |  |  |  |  |  |  |  isexec
( call ) |  |  |  |  |  |  |  |  |  |  isfile
( call ) |  |  |  |  |  |  |  |  |  join
( call ) |  |  |  |  |  |  |  |  |  isexec
( call ) |  |  |  |  |  |  |  |  |  |  isfile
( call ) |  |  |  |  |  |  |  |  |  join
( call ) |  |  |  |  |  |  |  |  |  isexec
( call ) |  |  |  |  |  |  |  |  |  |  isfile
( call ) |  |  |  |  |  |  |  |  |  |  |  S_ISREG
( call ) |  |  |  |  |  |  |  |  |  |  |  |  S_IFMT
( call ) |  |  |  |  |  |  |  |  is_program
( call ) |  |  |  |  |  |  |  |  |  getenv
( call ) |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  join
( call ) |  |  |  |  |  |  |  |  |  isexec
( call ) |  |  |  |  |  |  |  |  |  |  isfile
( call ) |  |  |  |  |  |  |  |  |  join
( call ) |  |  |  |  |  |  |  |  |  isexec
( call ) |  |  |  |  |  |  |  |  |  |  isfile
( call ) |  |  |  |  |  |  |  |  |  join
( call ) |  |  |  |  |  |  |  |  |  isexec
( call ) |  |  |  |  |  |  |  |  |  |  isfile
( call ) |  |  |  |  |  |  |  |  |  |  |  S_ISREG
( call ) |  |  |  |  |  |  |  |  |  |  |  |  S_IFMT
( call ) |  |  |  |  |  |  |  clear_readline_cache
( call ) |  |  |  |  |  |  current_level
( call ) |  |  |  |  |  |  get_child
( call ) |  |  |  |  |  |  |  fuzzy_get
( call ) |  |  |  |  |  |  execute_command
( call ) |  |  |  |  |  |  |  current_level
( call ) |  |  |  |  |  |  |  validate_arguments
( call ) |  |  |  |  |  |  |  |  getargspec
( call ) |  |  |  |  |  |  |  |  |  ismethod
( call ) |  |  |  |  |  |  |  |  |  isfunction
( call ) |  |  |  |  |  |  |  |  |  getargs
( call ) |  |  |  |  |  |  |  |  |  |  iscode
( call ) |  |  |  |  |  |  |  check_skill_level
( call ) |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  get_impl
( call ) |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  do_param
```

Остановимся на секундочку и посмотрим определение функции `do_param()`:

```python
    @command.skill_level('administrator')
    @command.wait
    @command.completers(compl.resources, _attrcmds)
    def do_param(self, context, rsc, cmd, param, value=None):
        """usage:
        param <rsc> set <param> <value>
        param <rsc> delete <param>
        param <rsc> show <param>"""
        return ui_utils.manage_attr(context.get_command_name(), self.rsc_param,
                                    rsc, cmd, param, value)
```

посмотрим некоторые значения:

```
context.get_command_name():
'param'

rsc:
'rsc'

cmd:
'show'

param:
'test'

self.rsc_param:
{'show': "crm_resource -r '%s' -g '%s'", 'get': "crm_resource -r '%s' -g '%s'", 'set': "crm_resource -r '%s' -p '%s' -v '%s'", 'delete': "crm_resource -r '%s' -d '%s'"}

```

Как видно, в качестве основной команды используется `crm_resource ...`,
т.е. никакой принципиальной разницы между использованием `crm ` и `crm_*` нет 
(по крайней мере на уровне логики)

Возможно, дальше есть различия, об этом чуть ниже

```
( call ) |  |  |  |  |  |  |  |  get_command_name
( call ) |  |  |  |  |  |  |  |  manage_attr
( call ) |  |  |  |  |  |  |  |  |  sanity_check
( call ) |  |  |  |  |  |  |  |  |  |  is_name_sane
( call ) |  |  |  |  |  |  |  |  |  |  |  search
( call ) |  |  |  |  |  |  |  |  |  |  |  |  isstring
( call ) |  |  |  |  |  |  |  |  |  |  |  |  compile
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  isstring
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  parse
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  match
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  match
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  append
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  match
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  getwidth
( call ) |  |  |  |  |  |  |  |  |  sanity_check
( call ) |  |  |  |  |  |  |  |  |  |  is_name_sane
( call ) |  |  |  |  |  |  |  |  |  |  |  search
( call ) |  |  |  |  |  |  |  |  |  ext_cmd
( call ) |  |  |  |  |  |  |  |  |  |  add_sudo
( call ) |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  get_impl
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  common_debug
( call ) |  |  |  |  |  |  |  |  |  |  |  debug
( call ) |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  get_impl
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  call
( call ) |  |  |  |  |  |  |  |  |  |  |  pipe_cloexec
( call ) |  |  |  |  |  |  |  |  |  |  |  execvp
( call ) |  |  |  |  |  |  |  |  |  |  |  |  split
( call ) |  |  |  |  |  |  |  |  |  |  |  wait
```
**Здесь.** Здесь (насколько я понял) запускается асинхронный процесс(?) 
с выполнением комады, описанной в предыдущем пояснении.

Далее мы видем вывод этой команды, аналогичной 
`crm_resource --resource rsc --get-parameter=test`

```
3
```

Далее видно, что питоновский процесс ждёт её завершения.

И вот тут я не уверен, выполняется ли повторный запрос в случае неудачи, 
к сожалению не смотрел код в этом месте

```
( call ) |  |  |  |  |  |  |  should_wait
( call ) |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  get_impl
( call ) |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  up
( call ) |  |  |  |  |  |  |  current_level
( call ) |  |  |  |  |  |  |  end_game
( call ) |  |  |  |  |  |  |  clear_readline_cache
( call ) |  |  |  |  |  render_prompt
( call ) |  |  |  |  |  |  cib_prompt
( call ) |  |  |  |  |  |  |  get_cib_in_use
( call ) |  |  |  |  |  |  prompt
( call ) |  |  |  |  |  |  |  <genexpr>
( call ) |  |  |  |  |  |  colors_enabled
( call ) |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  get_impl
( call ) |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  prompt
( call ) |  |  |  |  |  |  |  colors_enabled
( call ) |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  get_impl
( call ) |  |  |  |  |  |  |  |  |  |  has_option
( call ) |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  |  |  |  |  |  optionxform
( call ) |  |  |  |  |  |  |  |  |  get
( call ) |  |  |  |  |  |  render
( call ) |  |  |  |  |  |  |  sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  |  |  |  render_sub
( call ) |  |  |  |  |  multi_input
crm(live)#
```

### Запуск Python VM или "почему такая большая разница во времени" 

Сравнивая `crm `(`crmsh`) и `crm_*`, выяснено, что `get` параметра осуществляется с разницей 
примерно 0.15 секунды. Это именно то время, которое нужно `crmsh` чтобы запустить виртуалку 
и загрузить туда весь нужный для работоспособности код.

Если работать в интерактивной среде (т.е. в "прогретой" виртуалке), 
то разница во времени практически не заметна.

#### Проблема скорее даже не в самой виртуалке питона, а в количестве кода `crmsh`.

При первом запуске, `crmsh` осуществляет около 25k вызовов функций 
(исключая `os.write()`, а так же функции, начинающиеся на `_`)

Код для подсчёта количества функций и вывода стектрейса на экран:

```python
import sys

global_pad = 0

def leftpad(n_spaces):
    res = ""
    for i in range(n_spaces):
        res += "|  "
    return res


def trace_calls_and_returns(frame, event, arg):
    global global_pad
    #print 'event ' + event
    co = frame.f_code
    func_name = co.co_name
    if func_name == 'write' or func_name[0] == '_':
        # Ignore write() calls from print statements
        return
    line_no = frame.f_lineno
    filename = co.co_filename
    if event == 'call':
        global_pad += 1
        print '( call ) %s%s ' % (leftpad(global_pad), func_name) #, line_no, filename)
        return trace_calls_and_returns
    elif event == 'return':
        #print '(return) %s%s ' % (leftpad(global_pad), func_name) #, arg)
        global_pad -= 1
    return
```


