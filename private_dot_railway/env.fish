set -gx RAILWAY_HOME '/Users/obiabo/.railway'
if not contains "$RAILWAY_HOME/bin" $PATH
  set -gx PATH "$RAILWAY_HOME/bin" $PATH
end
