classdef ConsoleSinkTest < matlab.unittest.TestCase
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
        function testWritePrintsToCommandWindow(tc)
            sink = logger.sink.ConsoleSink(); %#ok<NASGU>

            captured = evalc('sink.write(sprintf(''Hello Console\\n''))');

            tc.verifyNotEmpty(captured);
            tc.verifyThat(captured, matlab.unittest.constraints.ContainsSubstring('Hello Console'));
        end
    end
end
