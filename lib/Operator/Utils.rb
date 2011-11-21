module Operator
  
  class Utils
    
    def Utils.eval(var_Name, var_QRES, var_ENVS)
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: Before operation, object name [#{var_Name}]\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
      
      var_QRES.push(var_ENVS.bind(var_Name))
      
      Common::Logger.print(Common::VAR_DEBUG, self, "[eval]: After operation, object name [#{var_Name}]\n#{var_QRES.to_s()}\n#{var_ENVS.to_s()}")
    end
    
  end
end