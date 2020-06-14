{ ... }:

{
  programs.htop = {
    enable = true;
    colorScheme = 6;
    meters.right = [ "Tasks" "Uptime" ];
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
    showProgramPath = false;
    highlightBaseName = true;
  };
}
