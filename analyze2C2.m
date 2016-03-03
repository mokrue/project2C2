%cd 'C:\Users\Mo\Documents\Uni Daten\KTH vt16\SF2812 Applied Linear Optimization\2C'
clear all;
nmap = 20;
    map = [[linspace(0,1,nmap) linspace(1,1,nmap)]' [linspace(1,1,nmap) linspace(1,0,nmap)]' [linspace(0,0,nmap) linspace(0,0,nmap)]'];
%    
% i.name = 'i';
% i.uels = {'Arboga', 'Fagersta', 'Ludvika', 'Nykoping'};
% j.name = 'j';
% j.uels = {'Eskilstuna', 'Falun', 'Gavle', 'Norrkoping', 'Stockholm', 'Uppsala', 'Vasteras', 'Orebro'};
% d.name = 'd';
% d.uels = {'normal', 'overweight'};
% s.name = 's';
% s.uels = {'-3\sigma', '-2\sigma', '-\sigma', '\pm 0', '+\sigma', '+2\sigma', '+3\sigma'};
% 
% cap.name = 'cap';
% cap.val = [7 8 9 8];
% %cap.val = [ 8.200,  8.550,  9.000, 13.800];
% cap.type = 'parameter';
% cap.form = 'full';
% cap.uels = i.uels;
% 
% dem.name = 'dem';
% dem.val = [2 2 4 3 9 6 3 2];
% dem.type = 'parameter';
% dem.form = 'full';
% dem.uels = j.uels;
% 
% tra.name = 'tra';
% tra.val = [1000 1400];
% tra.type = 'parameter';
% tra.form = 'full';
% tra.uels = d.uels;
% 
% del.name = 'del';
% del.val = [-3 -2 -1 0 1 2 3];
% del.type = 'parameter';
% del.form = 'full';
% del.uels = s.uels;
% 
% p.name = 'p';
% p.val = [0.0062
%     0.0606
%     0.2417
%     0.3830
%     0.2417
%     0.0606
%     0.0062];
% p.type = 'parameter';
% p.form = 'full';
% p.uels = s.uels;
% 
% dist.name = 'dist';
% dist.val = [
%     45   165   195     110       156       129      52      40
%     95    88   126     187       176       117      66     103
%     137    63   150     220       222       163     112     112
%     82   260   257      59       106       168     128     135
%     ];
% dist.form = 'full';
% dist.type = 'parameter';
% dist.uels = {i.uels, j.uels};
% 
% %% Run GAMS
% model = 'basic'; %'basic';
% wgdx('MtoG',i,j,d,s,cap,dem,tra,del,p,dist);
% % gdxInfo MtoG
% cd 'C:\Users\Mo\Documents\Uni Daten\KTH vt16\SF2812 Applied Linear Optimization\1D'
% if strcmp(model,'advanced')
%     system 'C:\GAMS\win64\24.6\gams advanced1D3GtoM lo=3 gdx=GtoM --gdxin=MtoG';
% elseif strcmp(model,'basic')
%     system 'C:\GAMS\win64\24.6\gams basic1D3GtoM lo=3 gdx=GtoM --gdxin=MtoG';
% end

%% Read GDX - Gams Data eXchange
model = 'basic';
% cd 'C:\Users\Mo\Documents\Uni Daten\KTH vt16\SF2812 Applied Linear Optimization\2C'
% gdxWhos basResults2C2
gdxname = 'stipend2C2BASIC';%'out';%'basResults2C2'

x.name = 'x';
x.compress = 'true';
x = rgdx(gdxname,x);

avg.name = 'AverageGrade';
avg.compress = 'true';
avg = rgdx(gdxname,avg);
% 
% z.name = 'z';
% z.compress = 'true';
% z = rgdx('GtoM',z);
% 
% if strcmp(model,'advanced')
%     capcon.name = 'ADVCAPCON';
%     capcon.field = 'm';
%     capcon = rgdx('GtoM',capcon);
%     capcon.val(:,2) = capcon.val(:,2) - 14;
%     
%     ycap.name = 'ycap';
% ycap.compress = 'true';
% ycap = rgdx('GtoM',ycap);
% 
% 
% elseif strcmp(model,'basic')
%     capcon.m.name = 'BASCAPCON';
%     capcon.m.field = 'm';
%     capcon.m = rgdx('GtoM',capcon.m);
%     
%     capcon.up.name = 'BASCAPCON';
%     capcon.up.field = 'up';
%     capcon.up = rgdx('GtoM',capcon.up);
%     
%     capcon.l.name = 'BASCAPCON';
%     capcon.l.field = 'l';
%     capcon.l = rgdx('GtoM',capcon.l);
% end
% 
% 
%% Plot Data
close(gcf);
set(0,'DefaultTextInterpreter', 'latex')
%% Bubble Units X
if false
    hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
        'Units','normalized','Color',[1 1 1],...
        'Position',[0 0 1 1]);
    axes;
    ax = gca;
    ax.OuterPosition = [0 0 1 1];
    
    x.plot.val = x.val;
    x.plot.val(end+1,:) = 0;
%     if strcmp(model,'basic')
%         x.plot.val(end,3) = max(z.val(:,3));
%     elseif strcmp(model,'advanced')
%         x.plot.val(end,3) = max(z.val(:,4));
%     end
    x.plot.val(end,3) = max(x.val(:,3));
    
    x.plot.I = x.plot.val(:,1);
    x.plot.J = x.plot.val(:,2);
    x.plot.XL = x.plot.val(:,3);
    
    hold on;
    scale = 1/10000;
    scatter(ax,x.plot.J,x.plot.I,[x.plot.XL(1:end-1).*scale; 0],x.plot.XL,'filled');
    text(x.plot.J(1:end-1),x.plot.I(1:end-1) - 0.03,num2cell(x.plot.XL(1:end-1)'),'FontName','FixedWidth','FontSize',20,'Color','k','FontWeight','bold','HorizontalAlignment','center');
    
    alpha(.5)
    
    hold off;
    
    ax.XRuler.Axle.Visible = 'off';
    ax.YRuler.Axle.Visible = 'off';
    ax.TickLength = [0 0];
    
    ax.XTick = 1:max(floor(x.plot.J));
    ax.XTickLabelRotation = -45;
    %ax.XTickLabel = j.uels;
    ax.XGrid = 'on';
    
    ax.YTick = 1:max(floor(x.plot.I));
    ax.YTickLabelRotation = 45;
    %ax.YTickLabel = i.uels;
    ax.YGrid = 'on';
    
    xlabel('Scholars \(j\)','Interpreter','LaTex');
    ylabel('Students \(i\)','Interpreter','LaTex');
    ax.FontSize = 18;
    ax.LineWidth = 1;
    ax.GridAlpha = 1;
    
    h = colorbar(ax,'eastoutside');
    h.Label.String = 'Money Awardd \(x_{ij}\) [SEK]';
    h.Label.Interpreter = 'LaTex';
    h.Box = 'off';
    h.Ruler.Axle.Visible = 'off';
    h.Limits = [0 x.plot.val(end,3)];
    h.TickLength = 0;
     colormap(ax,map);
    
    axis equal tight;
    
end

%% Bar Units B
if true
    hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
        'Units','normalized','Color',[1 1 1],...
        'Position',[0 0 1 1]);
    axes;
    ax = gca;
    ax.OuterPosition = [0 0 1 1];
    
    x.plot.val = x.val; 
    avg.plot.val = avg.val; 
    x.plot.I = flipud(avg.plot.val(:,2));
    x.plot.XL = flipud(x.plot.val(:,3));
    
    hold on;
    scatter(ax,x.plot.I,x.plot.XL,20,'o','b','filled');
    line([4.3 5],[4000 4000],'LineWidth',1,'Color','k');
    line([4.3 5],[18000 18000],'LineWidth',1,'Color','k');
    hold off;
    
    ax.XLim = [4.3 5];
    ax.YLim = [0 25000];
    ax.XGrid = 'on';
    ax.YGrid = 'on';
    xlabel('Average Grades of Students \(i\)','Interpreter','LaTex');
    ylabel('Money Received [SEK]','Interpreter','LaTex');
    ax.FontSize = 18;
    ax.LineWidth = 1;       
end

%% Bubble Units Z basic
% if strcmp(model,'basic')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     ax.OuterPosition = [0 0 1 1];
%     
%     z.plot.val = z.val;
%     z.plot.val(end+1:end+3,:) = 0;
%     z.plot.val(end-1,2) = 7;
%     z.plot.val(end,2) = 8;
%     
%     z.plot.I = z.plot.val(:,1);
%     z.plot.J = z.plot.val(:,2);
%     
%     z.plot.ZL = z.plot.val(:,3);
%     
%     hold on;
%     scale = 2000;
%     scatter(ax,z.plot.J,z.plot.I,z.plot.ZL.*scale,z.plot.ZL,'filled');
%     text(z.plot.J(1:end-3),z.plot.I(1:end-3) - 0.03,num2cell(z.plot.ZL(1:end-3)'),'FontName','FixedWidth','FontSize',20,'Color','k','FontWeight','bold','HorizontalAlignment','center');
%     alpha(.5)
%     
%     hold off;
%     
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     ax.TickLength = [0 0];
%     
%     ax.XTick = 1:max(floor(z.plot.J));
%     ax.XTickLabelRotation = -45;
%     ax.XTickLabel = j.uels;
%     ax.XGrid = 'on';
%     
%     ax.YTick = 1:max(floor(z.plot.I));
%     ax.YTickLabelRotation = 45;
%     ax.YTickLabel = i.uels;
%     ax.YGrid = 'on';
%     
%     xlabel('Cities \(j\)','Interpreter','LaTex');
%     ylabel('Plants \(i\)','Interpreter','LaTex');
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     ax.GridAlpha = 1;
%     
%     h = colorbar(ax,'eastoutside');
%     h.Label.String = 'Shipped Waste \(x_{ij}^{*}\) [tons]';
%     h.Label.Interpreter = 'LaTex';
%     h.Box = 'off';
%     h.Ruler.Axle.Visible = 'off';
%     h.Limits = [0 max(z.val(:,3))];
%     h.TickLength = 0;
%     
%     colormap(ax,map);
%     
%     axis equal tight;
%     
% end
% 
% %% Bubble Units Z advanced
% if strcmp(model,'advanced')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     ax.OuterPosition = [0 0 1 1];
%     
%     z.plot.val = flipud(z.val);
%     z.plot.val(end+1,:) = 0;
%     z.plot.I = z.plot.val(:,1);
%     z.plot.J = z.plot.val(:,2);
%     z.plot.S = z.plot.val(:,3);
%     scale = 2000;
%     z.plot.ZL = z.plot.val(:,4);
%     
%     hold on;
%     scatter3(ax,z.plot.I,z.plot.J,z.plot.S,z.plot.ZL.*scale,z.plot.S,'filled');
% %     text(z.plot.I,z.plot.J - 0.03,num2cell(z.plot.ZL'),'FontName','FixedWidth','FontSize',20,'Color','k','FontWeight','bold','HorizontalAlignment','center');
%     alpha(.5)
%     
%     hold off;
%     
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     ax.TickLength = [0 0];
%     
%     ax.YTick = 1:max(floor(z.plot.J));
%     ax.YTickLabelRotation = -45;
%     ax.YTickLabel = j.uels;
%     ax.YGrid = 'on';
%     
%     ax.XTick = 1:max(floor(z.plot.I));
%     ax.XTickLabelRotation = 45;
%     ax.XTickLabel = i.uels;
%     ax.XGrid = 'on';
%     
%     ylabel('Cities \(j\)','Interpreter','LaTex');
%     xlabel('Plants \(i\)','Interpreter','LaTex');
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     ax.GridAlpha = 1;
%     
%     h = colorbar(ax,'eastoutside');
%     h.Label.String = 'Scenrios \(s\)';
%     h.Label.Interpreter = 'LaTex';
%     h.Box = 'off';
%     h.Ruler.Axle.Visible = 'off';
%     h.Limits = [1 max(floor(z.plot.S))];
%     h.TickLabels = s.uels;
%     h.TickLength = 0;
%     
%     colormap(ax,map);
%     view(ax,[90 -90]);
%     axis equal tight;
%     
% end
% 
% %% Bar Margin Bas
% if strcmp(model,'basic')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     ax.OuterPosition = [0 0 1 1];
%     
%     capcon.plot.I = capcon.m.val(:,1);
%     capcon.plot.m = abs(capcon.m.val(:,2));
%     
%     bar(capcon.plot.I, capcon.plot.m,0.3,'g');
%     
%     ax.TickLength = [0 0];
%     
%     ax.XTick = 1:max(floor(capcon.plot.I));
%     ax.XTickLabelRotation = 0;
%     ax.XTickLabel = i.uels;
%     %     ax.XGrid = 'on';
%     
%     %     ax.YTick = 1:max(floor(capcon.plot.I));
%     %     ax.YTickLabelRotation = 0;
%     %     ax.YTickLabel = i.uels;
%     %     ax.YGrid = 'on';
%     
%     %     zlabel('Scenarios \(s\)','Interpreter','LaTex');
%     xlabel('Plants \(i\)','Interpreter','LaTex');
%     ylabel('Margin [SEK]','Interpreter','LaTex');
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     
%     colormap(ax,map);
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     %     ax.ZRuler.Axle.Visible = 'off';
%     
% end
% 
% %% Bar Usage Bas
% if strcmp(model,'basic')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     ax.OuterPosition = [0 0 1 1];
%     
%     capcon.plot.I = capcon.l.val(:,1);
%     capcon.plot.l = abs(capcon.l.val(:,2));
%     capcon.plot.up = abs(capcon.up.val(:,2));
%     
%     hold on;
%     bar(capcon.plot.I, capcon.plot.up,0.3,'g');
%     bar(capcon.plot.I, capcon.plot.l,0.3,'r');
%     %     bar([capcon.plot.up capcon.plot.l]);
%     hold off;
%     
%     %     map = [0.5, 0, 0; 0, 0, 1];
%     %     colormap(map);
%     
%     ax = gca;
%     ax.TickLength = [0 0];
%     
%     ax.XTick = 1:max(floor(capcon.plot.I));
%     ax.XTickLabelRotation = 0;
%     ax.XTickLabel = i.uels;
%     %     ax.XGrid = 'on';
%     
%     %     ax.YTick = 1:max(floor(capcon.plot.I));
%     %     ax.YTickLabelRotation = 0;
%     %     ax.YTickLabel = i.uels;
%     %     ax.YGrid = 'on';
%     
%     %     zlabel('Scenarios \(s\)','Interpreter','LaTex');
%     xlabel('Plants \(i\)','Interpreter','LaTex');
%     ylabel('Usage compared to Capacity \(a_i\)','Interpreter','LaTex');
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     
%     colormap(ax,map);
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     %     ax.ZRuler.Axle.Visible = 'off';
%     
% end
% 
% %% Bar Margin Adv
% if strcmp(model,'advanced')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     ax.OuterPosition = [0 0 1 1];
%     try
%     
%     capcon.plot.I = capcon.val(:,1);
%     capcon.plot.S = capcon.val(:,2);
%     
%     for i_idx = 1:max(floor(capcon.plot.I))
%         for s_idx = 1:max(floor(capcon.plot.S))
%             tmp = capcon.val(((capcon.val(:,1) == i_idx) & (capcon.val(:,2) == s_idx)),3);
%             if isempty(tmp)
%                 tmp = NaN;
%             end
%             capcon.plot.m(i_idx, s_idx) = tmp;
%         end
%     end
%     
%     capcon.plot.ms = [capcon.plot.m(4,:); capcon.plot.m(1:3,:)];
%     
%     bar3(capcon.plot.ms);
%     alpha(.7)
%     
%     
%     ax.TickLength = [0 0];
%     
%     ax.XTick = 1:max(floor(capcon.plot.S));
%     ax.XTickLabelRotation = 0;
%     ax.XTickLabel = s.uels;
%     ax.XGrid = 'on';
%     
%     ax.YTick = 1:max(floor(capcon.plot.I));
%     ax.YTickLabelRotation = 0;
%     ax.YTickLabel = {i.uels{4} i.uels{1:3}};
%     ax.YGrid = 'on';
%     
%     xlabel('Scenarios \(s\)','Interpreter','LaTex');
%     ylabel('Plants \(i\)','Interpreter','LaTex');
%     zlabel('Margin [SEK]');
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     
%     view(ax,[34.5 22]);
%     
%     colormap(ax,map);
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     ax.ZRuler.Axle.Visible = 'off';
%     catch
%     end
%     
% end
% 
% %% Bar Increased Capacity
% if strcmp(model,'advanced')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     ax.OuterPosition = [0 0 1 1];
%     capconA.plot.m = [ 8.200,  8.550,  9.000, 13.800];
%     
%     hold on;
%     bar([1:4], capconA.plot.m,0.3,'g');
%     bar([1:4], cap.val,0.3,'k');
%     text([1:4],capconA.plot.m + 0.5,num2cell(capconA.plot.m'),'FontName','FixedWidth','FontSize',20,'Color','k','FontWeight','bold','HorizontalAlignment','center');
% text([1:4],cap.val - 0.5,num2cell(cap.val'),'FontName','FixedWidth','FontSize',20,'Color','w','FontWeight','bold','HorizontalAlignment','center');
% 
%     hold off;
%     
%     ax.TickLength = [0 0];
%     
%     ax.XTick = 1:max(floor(capcon.plot.I));
%     ax.XTickLabelRotation = 0;
%     ax.XTickLabel = i.uels;
%     %     ax.XGrid = 'on';
%     
%     %     ax.YTick = 1:max(floor(capcon.plot.I));
%     %     ax.YTickLabelRotation = 0;
%     %     ax.YTickLabel = i.uels;
%     %     ax.YGrid = 'on';
%     
%     %     zlabel('Scenarios \(s\)','Interpreter','LaTex');
%     xlabel('Plants \(i\)','Interpreter','LaTex');
%     ylabel('Capacity','Interpreter','LaTex');
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     
%     colormap(ax,map);
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     %     ax.ZRuler.Axle.Visible = 'off';
%     
% end
% 
% %% Line Increased Capacity 
% if strcmp(model,'advanced')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     
%     ax.OuterPosition = [0 0 1 1];
%     IncCapValue = [
%         -11747
% 262199
% 532051
% 769850
% 914333
% 991654
% 1056446
% 1109080
% 1142693    
%     ];
% % IncCapValue = IncCapValue - IncCapValue(5);
%     hold on;
%     liwi = 2;
% 
%     tmp = -20:5:20;
% %     bar(tmp,IncCapValue(5) .* ones(1,length(IncCapValue)),'r');
% %     bar(tmp,IncCapValue,'k');
% %     bar(tmp,[NaN; NaN; NaN; NaN; IncCapValue(5:end)],'g');
% %     bar(tmp,[NaN; NaN; NaN; NaN; IncCapValue(5) .* ones(5,1)],'k');
% bar(tmp,IncCapValue,'k');
% bar(tmp,[NaN; NaN; NaN; NaN; NaN; IncCapValue(6:end)],'g');
% bar(tmp,[IncCapValue(1:4); NaN; NaN; NaN; NaN; NaN],'r');
% 
%     hold off;
%     
%     ax.TickLength = [0 0];
%     
%     ax.XTick = tmp;
%     
%     labi = strread(num2str(tmp),'%s')';
%     
%         for idxx = 1:length(labi)
%         labi{idxx} = [labi{idxx} '%'];
%         end
%     
%     ax.XTickLabel = labi;
%     ax.XLimMode = 'auto';
%     ax.YLimMode = 'auto';
%     ax.XGrid = 'off';
%     ax.YGrid = 'off';
%     
%     xlabel('$\Delta a_i$','Interpreter','LaTex');
%     ylabel('$\Delta yield$ [SEK]','Interpreter','LaTex');
%     
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     
% %     ax.XRuler.Axle.Visible = 'off';
% %     ax.YRuler.Axle.Visible = 'off';
%     
%     
% end
% %% Line Performance Distribution
% if strcmp(model,'advanced')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     %         'PaperUnits','points',...
%     %         'PaperOrientation','portrait','PaperType','<custom>',...
%     %         'PaperPositionMode','auto',...
%     %         'PaperSize',[2000 1000],...
%     %         'PaperPosition',[0 0 2000 1000]);
%     
%     ax = axes();
%     hold on;
%     liwi = 2;
%     stairs([del.val(1) del.val del.val(end) + 1 del.val(end) + 1] - 0.5,[0 p.val' p.val(end) 0], 'LineWidth', liwi);
%     tmp = linspace(-3.5,3.5);
%     plot(tmp,normpdf(tmp), 'LineWidth', liwi);
%     
%     xlabel('Scenarios \(s\)','Interpreter','LaTex');
%     ylabel('Probability  \(p(s)\)','Interpreter','LaTex');
%     
%     ax.TickLength = [0 0];
%     ax.XTick = -3:length(s.uels)-4;
%     ax.XTickLabel = s.uels;
%     ax.XGrid = 'on';
%     ax.YGrid = 'on';
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     
%     lege = legend('discretization','normal distribution $\mu = b_j $, $ \sigma = 5\%$', 'Location', 'northwest');
%     set(lege,'Interpreter','Latex');
%     ax.XLim = [-5 5];
%     
%     ax.YLim = [0 0.5];
%     
%     ax2 = axes('Position',ax.Position,...
%         'XAxisLocation','top',...
%         'YAxisLocation','right',...
%         'Color','none');
%     
%     yieldPI =[
%         1014350
%         1032700
%         1052550
%         1059180
%         1023370
%         982200
%         871510
%         633180
%         389670
%         144960];
%     
%     yieldRP =[
%         972579
%         1000944
%         1016561
%         1004607
%         966813
%         914333
%         797251
%         592042
%         355407
%         112933 ];
%     
%     
%     hold on;
% %     plot(ax2,-5:4,yieldPI, 'LineWidth', liwi,'Color','g');
%     plot(ax2,-5:4,yieldRP, 'LineWidth', liwi,'Color','k');
%     hold off;
% %     lege = legend('yield for $ b_j^{*} = b_j + k \times 5\% $, $ \sigma = 0 $', 'yield for $ b_j^{*} = b_j + k \times 5\% $, $ \sigma = 5\% $', 'Location','northeast');
%     lege = legend('yield for $ b_j^{*}(k) $', 'Location','northeast');
%     set(lege,'Interpreter','Latex');
%     ax2.XLim = [-5 5];
%     ax2.XTick = -3:length(s.uels)-4;
% %     for idxx = 1:length(s.uels)
% %         labi{idxx} = ['$b_j^{*}' s.uels{idxx} '$'];
% %     end
% %     ax2.XTickLabel = labi;
% ax2.XTickLabel = {'-3' '-2' '-1' '0' '1' '2' '3' '4'};
%     ax2.TickLabelInterpreter = 'Latex';
%     
%     ax2.YLim = [0 1200000];    
%     xlabel('$k$','Interpreter','Latex');
%     ylabel('[SEK]','Interpreter','Latex');
%     ax2.TickLength = [0 0];
%     ax2.FontSize = 18;
%     ax2.OuterPosition = [0 0 1 1];
%     ax.OuterPosition = [0 0 1 1];
%     ax2.LineWidth = 1;
%     ax2.XRuler.Axle.Visible = 'off';
%     ax2.YRuler.Axle.Visible = 'off';
% end
% 
% %% Line Distribution
% if strcmp(model,'advanced')
%     hfig = figure('Name','Performance','NumberTitle','off','Renderer','painters',...
%         'Units','normalized','Color',[1 1 1],...
%         'Position',[0 0 1 1]);
%     axes;
%     ax = gca;
%     
%     hold on;
%     liwi = 2;
%     stairs([del.val(1) del.val del.val(end) + 1 del.val(end) + 1] - 0.5,[0 p.val' p.val(end) 0], 'LineWidth', liwi);
%     tmp = linspace(-3.5,3.5);
%     plot(tmp,normpdf(tmp), 'LineWidth', liwi);
%     hold off;
%     
%     ax.TickLength = [0 0];
%     
%     ax.XTick = -3:length(s.uels)-4;
%     
%     ax.XTickLabel = s.uels;
%     ax.XGrid = 'on';
%     ax.YGrid = 'on';
%     
%     xlabel('Scenarios \(s\)','Interpreter','LaTex');
%     ylabel('Probability  \(p(s)\)','Interpreter','LaTex');
%     
%     ax.FontSize = 18;
%     ax.LineWidth = 1;
%     ax.OuterPosition = [0 0 1 1];
%     ax.XRuler.Axle.Visible = 'off';
%     ax.YRuler.Axle.Visible = 'off';
%     
%     
% end
% 
% %% Export Figures
% if false
%     hfig = gcf;
%     print('-painters',hfig,[hfig.Name 'F'],'-dtiff','-r300');
%     matlab2tikz([hfig.Name 'F.tikz'], 'height', '\figureheight', 'width', '\figurewidth');
% end
