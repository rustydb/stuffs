command: "ps axro \"pid, %cpu, ucomm\" | awk 'FNR>1' | head -n 3 | awk '{ printf \"%5.1f%%,%s,%s\\n\", $2, $3, $1}'"

refreshFrequency: 2000

style: """
  bottom: 100px
  left: 10px
  color: #fff
  font-family: Helvetica Neue

  table
    border-collapse: collapse
    table-layout: fixed

    &:after
      content: 'CPU'
      position: absolute
      left: 0
      top: -14px
      font-size: 12px

  td
    border: 1px solid #fff
    font-size: 28px
    font-weight: 105
    width: 140px
    max-width: 140px
    overflow: hidden
    text-shadow: 0 0 1px rgba(#000, 0.5)

  .wrapper
    padding: 4px 6px 4px 6px
    position: relative

  .col1
    background: rgba(#C0C0C0, 0.5)

  .col2
    background: rgba(#C0C0C0, 0.3)

  .col3
    background: rgba(#C0C0C0, 0.1)

  p
    padding: 0
    margin: 0
    font-size: 11px
    font-weight: normal
    max-width: 100%
    color: #ddd
    text-overflow: ellipsis
    text-shadow: none

  .pid
    position: absolute
    top: 2px
    right: 2px
    font-size: 10px
    font-weight: normal

"""


render: -> """
  <table>
    <tr>
      <td class='col1'></td>
      <td class='col2'></td>
      <td class='col3'></td>
    </tr>
  </table>
"""

update: (output, domEl) ->
  processes = output.split('\n')
  table     = $(domEl).find('table')

  renderProcess = (cpu, name, id) ->
    "<div class='wrapper'>" +
      "#{cpu}<p>#{name}</p>" +
      "<div class='pid'>#{id}</div>" +
    "</div>"

  for process, i in processes
    args = process.split(',')
    table.find(".col#{i+1}").html renderProcess(args...)

