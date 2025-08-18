classdef LogLevelTest < matlab.unittest.TestCase
    methods (TestMethodSetup)
        function addSrcToPath(~)

            % Add src to path so package +logger is discoverable.
            root = fileparts(fileparts(mfilename('fullpath')));
            srcdir = fullfile(root, 'src');

            if ~contains(path, srcdir)
                addpath(srcdir);
            end

            % Reset singletons/persistent state.
            clear classes; %#ok<CLCLS>
        end
    end

    methods(Test)
        function testFromNameAndName(tc)
            tc.verifyEqual(logger.LogLevel.fromName('debug'), logger.LogLevel.DEBUG);
            tc.verifyEqual(logger.LogLevel.fromName('INFO'), logger.LogLevel.INFO);
            tc.verifyEqual(logger.LogLevel.fromName('Fatal'), logger.LogLevel.FATAL);
            tc.verifyEqual(logger.LogLevel.name(logger.LogLevel.ERROR), "error");
            tc.verifyEqual(logger.LogLevel.name(logger.LogLevel.OFF), "off");
        end

        function testInvalidNameThrows(tc)
            didThrow = false;

            try
                logger.LogLevel.fromName('this_is_not_a_level');
            catch
                didThrow = true;
            end

            tc.verifyTrue(didThrow, 'logger.LogLevel.fromName should throw for unknown level names');
        end
    end
end

