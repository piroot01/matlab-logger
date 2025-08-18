classdef LogLevel
    properties (Constant)
        TRACE = 0;
        DEBUG = 10;
        INFO = 20;
        WARN = 30;
        ERROR = 40;
        FATAL = 50;
        OFF = 1e9;
    end

    methods (Static)
        function level = fromName(name)
            if isempty(name)
                error('LogLevel.fromName: empty name');
            end

            switch lower(string(name))
                case "trace", level = LogLevel.TRACE;
                case "debug", level = LogLevel.DEBUG;
                case "info", level = LogLevel.INFO;
                case "warn", level = LogLevel.WARN;
                case "error", level = LogLevel.ERROR;
                case "fatal", level = LogLevel.FATAL;
                case "off", level = LogLevel.OFF;
                otherwise
                    error('Unknown log level name: %s', name);
            end
        end

        function name = name(level)
            if level == LogLevel.TRACE
                name = "trace";
                return;
            end

            if level == LogLevel.DEBUG
                name = "debug";
                return;
            end

            if level == LogLevel.INFO
                name = "info";
                return;
            end

            if level == LogLevel.WARN
                name = "warn";
                return;
            end

            if level == LogLevel.ERROR
                name = "error";
                return;
            end

            if level == LogLevel.FATAL
                name = "fatal";
                return;
            end

            if level == LogLevel.OFF
                name = "off";
                return;
            end

            name = "level(" + string(level) + ")";
        end
    end
end
