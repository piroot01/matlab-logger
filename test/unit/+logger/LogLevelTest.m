classdef LogLevelTest < matlab.unittest.TestCase
    methods (TestMethodSetup)
        function addSrcToPath(~)
            % Find the project root by walking up until we find "src" folder
            p = fileparts(mfilename('fullpath'));

            while ~isempty(p) && ~exist(fullfile(p,'src'),'dir')
                p = fileparts(p);
            end

            if isempty(p)
                error('Could not find project root containing "src". Run tests from project tree or adjust detection.');
            end

            srcdir = fullfile(p,'src');
            if ~contains(path, srcdir)
                addpath(srcdir);
            end

            % Reset singletons/persistent state.
            clear classes; %#ok<CLCLS>
        end
    end

    methods (Test)
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
