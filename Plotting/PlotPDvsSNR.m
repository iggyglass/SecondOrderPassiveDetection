function PlotPDvsSNR(channel)
    close all;
    
    dataPath = fullfile("Data/PDvsSNR", channel);
    fileStruct = dir(fullfile(dataPath, "*.csv"));

    dataFiles = {fileStruct.name};
    cmap = colormap("lines");

    varModels = [];
    fileNames = cellfun(@getName, dataFiles, "UniformOutput", false);

    % Each file in the list corresponds to a different variance model
    for i = 1:length(dataFiles)
        resultCorrect = readmatrix(fullfile(dataPath, dataFiles(i)));
        resultWrong = readmatrix(fullfile(dataPath, "Wrong", dataFiles(i)));
        resultDiversity = readmatrix(fullfile(dataPath, "Diversity", dataFiles(i)));
        resultWrongDiversity = readmatrix(fullfile(dataPath, "Diversity/Wrong", dataFiles(i)));

        varModels(i) = plotData(resultCorrect, cmap(i, :), "-");
        pltWrong = plotData(resultWrong, cmap(i, :), ":");
        pltDiversity = plotData(resultDiversity, cmap(i, :), "--");
        pltWrongDiversity = plotData(resultWrongDiversity, cmap(i, :), "-.");
    end

    grid();

    fontname("Times");
    title(channel + " Channel $P_\mathrm{D}$ vs.\@ SNR", "Interpreter", "latex");
    xlabel("SNR [dB]", "Interpreter", "latex");
    ylabel("Probability of Detection", "Interpreter", "latex");

    [rf, ~] = legendflex(varModels, fileNames, "anchor", {'nw', 'nw'}, "buffer", [7, -7]);

    lineHandles = [varModels(1), pltWrong, pltDiversity, pltWrongDiversity];
    lineText = ["Correct Model", "Wrong Model", "Diversity", "Wrong Model Diversity"];
    [~, lf] = legendflex(lineHandles, cellstr(lineText), "ref", rf, "anchor", {'sw', 'nw'}, "buffer", [5, -5]);
    set(lf, 'Color', 'black');
end

function handle = plotData(data, color, style)
    handle = plot(data(1, :), data(2, :), "Color", color, "LineStyle", style, "LineWidth", 1);
    hold on;
end

function name = getName(fileStr)
    [~, name, ~] = fileparts(fileStr);
end
