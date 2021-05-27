{
  programs.htop = {
    enable = true;

    settings = {
      color_scheme = 6;
      highlight_base_name = true;
      right_meter_modes = [ "Tasks" "Uptime" ];
      show_program_path = false;
      fields = [
        "PID"
        "USER"
        "PRIORITY"
        "M_SIZE"
        "M_RESIDENT"
        "M_SHARE"
        "PERCENT_CPU"
        "PERCENT_MEM"
        "TIME"
        "COMM"
      ];
    };
  };
}
