module SBAStore
  
  # Class: NotInitialisedStoreException
  # Extends: RuntimeError
  #
  # Exeption thrown when user tries to use store without initializing
  # it properly first
  class NotInitialisedStoreException < RuntimeError
  end
end
