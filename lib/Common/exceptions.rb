# General exceptions
class OverwriteException < RuntimeError
end

class AbstractMethodException < RuntimeError
end

class InternalError < RuntimeError
end

class LogLevelError < RuntimeError
end

# SBA exceptions
class SBATypeError < ArgumentError
end

class SBAIndexError < ArgumentError
end

class SBAIdentifierError < ArgumentError
end

# QRES exceptions
class QRESTypeError < ArgumentError
end

