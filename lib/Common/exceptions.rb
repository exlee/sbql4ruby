# General exceptions
class OverwriteException < RuntimeError
end

class AbstractMethodException < RuntimeError
end

class InternalError < RuntimeError
end

class LogLevelError < RuntimeError
end

class IncorrectArgumentError < ArgumentError
end

# SBA exceptions
class SBATypeError < ArgumentError
end

class SBAIndexError < ArgumentError
end

class SBAIdentifierError < ArgumentError
end

# QRES exceptions
class NotInitialisedStackException < RuntimeError
end

class QRESTypeError < ArgumentError
end

# ENVS exceptions
class ENVSTypeError < ArgumentError
end

class ENVSNotInitialisedObjectException < RuntimeError
end

class ENVSIncorrectArgumentException < ArgumentError
end

