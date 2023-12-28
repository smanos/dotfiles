return {
  'itchyny/calendar.vim',
  config = function()
    require('user.credentials')
    vim.g.calendar_google_calendar = 1
    vim.g.calendar_google_task = 1
    vim.g.calendar_google_keep = 1
    vim.g.calendar_google_docs = 1
    vim.g.calendar_google_drive = 1
    vim.g.calendar_google_contact = 1
    vim.g.calendar_google_sync_seconds = 60
    vim.g.calendar_google_sync_minutes = 60
    vim.g.calendar_google_sync_hours = 24
    vim.g.calendar_google_sync_days = 7
    vim.g.calendar_google_sync_months = 12
    vim.g.calendar_google_sync_years = 10
    vim.g.calendar_google_sync_on_startup = 1
    vim.g.calendar_google_sync_on_exit = 1
    vim.g.calendar_google_sync_remind_minutes = 10
    vim.g.calendar_google_sync_remind_method = 'popup'
    vim.g.calendar_google_sync_remind_popup_time = 10
    vim.g.calendar_google_sync_remind_popup_position = 'center'
    vim.g.calendar_google_sync_remind_popup_max_width = 80
    vim.g.calendar_google_sync_remind_popup_max_height = 10
    vim.g.calendar_google_sync_remind_popup_border = 1
    vim.g.calendar_google_sync_remind_popup_border_chars = { '─', '│', '─', '│', '╭', '╮', '╯', '╰' }
    vim.g.calendar_google_sync_remind_popup_border_highlight = 'Normal'
    vim.g.calendar_google_sync_remind_popup_border_floating = 1
    vim.g.calendar_google_sync_remind_popup_border_title = 'Calendar'
    vim.g.calendar_google_sync_remind_popup_border_title_highlight = 'Title'
    vim.g.calendar_google_sync_remind_popup_border_title_align = 'center'
    vim.g.calendar_google_sync_remind_popup_border_title_padding = 1
    vim.g.calendar_google_sync_remind_popup_border_title_text = 'Calendar'
    vim.g.calendar_google_sync_remind_popup_border_title_text_highlight = 'Title'
    vim.g.calendar_google_sync_remind_popup_border_title_text_align = 'center'
    vim.g.calendar_google_sync_remind_popup_border_title_text_padding = 1
    vim.g.calendar_google_sync_remind_popup_border_title_text_width = 0
    vim.g.calendar_google_sync_remind_popup_border_title_text_wrap = 0
  end
}

