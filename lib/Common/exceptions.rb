# File: exceptions.rb
#
# Contains general exceptions, which are thrown on various problems or
# unexpected events.

# General exceptions
# Class: AbstractMethodException
# Extends: RuntimeError
#
# Thrown when user tries to call abstract method
class AbstractMethodException < RuntimeError
end

# Class: InternalError
# Extends: RuntimeError
# 
# Thrown by XML Parser to indicate object building error
class InternalError < RuntimeError
end

# Class: LogLevelError
# Extends: RuntimeError
#
# Thrown when user tries to set LogLevel beyond set values
class LogLevelError < RuntimeError
end

# Class: IncorrectArgumentError
# Extends: ArgumentError
#
# Thrown by Iterators to indicate non-interative datatype
class IncorrectArgumentError < ArgumentError
end

# SBA exceptions

# Class: SBATypeError
# Extends: ArgumentError
# 
# Thrown by SBA Datatypes to show that object type is incompatible
# with chosen SBA type
class SBATypeError < ArgumentError
end

# Class: SBAIndexError
# Extends: ArgumentError
#
# Thrown when user tries to obtain object using incorrect index
class SBAIndexError < ArgumentError
end


# QRES exceptions
# class NotInitialisedStackException
# extends RuntimeError
# 
# Thrown when user is trying to use QRES without initializing it first
class NotInitialisedStackException < RuntimeError
end

# class QRESTypeError
# extends ArgumentError
#
# Thrown on QRES type mismatch
class QRESTypeError < ArgumentError
end

# ENVS exceptions

# class ENVSTypeError
# extends ArgumentError
# 
# Thrown on type mismatch when using ENVS
class ENVSTypeError < ArgumentError
end

# class ENVSNotInitialisedObjectException
# extends RuntimeError
# 
# Thrown when user is trying to use ENVS without initializing it first 
class ENVSNotInitialisedObjectException < RuntimeError
end

# class ENVSIncorrectArgumentException  
# extends ArgumentError
# 
# Thrown on argument mismatch when using ENVS
class ENVSIncorrectArgumentException < ArgumentError
end
