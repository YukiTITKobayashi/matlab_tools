% fig_ax_check.m
% Pythonの以下(ネットの転がりもの)あたりをMATLABでできるようにして, 関数化したい
% fig, axes= plt.subplots(2,2)
% axes[0][0].plot([1,2,3])
% axes[1][0].plot([4,5,4,5])
clear
close all

%% サブプロットの検証
fig = figure;  % 図のハンドルを取得
% 各サブプロットのハンドルを取得
% subplotではfigとaxを紐付けるにはこうするしかない
% MATLABにsubplotsはない
% tiledlayoutは2019以後だから互換性悪
axs = zeros(2, 2); % 2x2の配列を初期化
for i = 1:4
    axs(i) = subplot(2,2,i,'Parent',fig);   %axesが予約語
end
% ax1 = subplot(2, 2, 1, 'Parent', fig); % 左上
% ax2 = subplot(2, 2, 2, 'Parent', fig); % 右上
% ax3 = subplot(2, 2, 3, 'Parent', fig); % 左下
% ax4 = subplot(2, 2, 4, 'Parent', fig); % 右下
% 各座標軸にプロットを作成
plot(axs(1), [1, 2, 3]); % 左上のサブプロットにプロット
plot(axs(3), [4, 5, 4, 5]); % 左下のサブプロットにプロット
title(axs(3), "axs3, title")
sgtitle("SG TITLE")
saveas(gcf,"test1.png")

%% プロット関数化
z = rand(8,10) + 1i * rand(8,10);
% figure初期化省略
% fig2 = figure;    
% ax = subplot(1,1,1,'Parent',fig2)
savepath = 'fig_test.png';
% plot_gain_z(z, [], savepath, 'keep');
plot_gain_z(z);


%% axにプロットする機能を維持しつつ, figのconstructorがない場合でも1行でプロットできる汎用プロット構成
% (保存もループ検証中の重ね書きや書き直し(close,clf)もできるモンテカルロシミュレーション用)
%Example
% plot_gain_z(z, [], "fig_test.png", 'keep');
% plot_gain_z(z); ←保存・closefigせずfigure初期化&プロット
% plot_gain_z(a, ax)  ...など

function [ax, fig] = plot_gain_z(z, ax, savepath, dstrct)
%plot_gain_z zのプロット
if ~exist('ax','var'); ax = []; end             % ax: 'matlab.graphics.axis.Axes', or 引数無or[]➡fig初期化
if ~exist('savepath','var'); savepath = []; end % savepath: string or char, or 引数無or[]➡保存無
if ~exist('dstrct','var'); dstrct = 'keep'; end % dstrct: 'keep'(default), 'closeaxes', 'clearfigure', 'closefigure'

if isempty(ax)  % ax空ならばfig,ax初期化
    fig = figure;   ax = subplot(1,1,1,'Parent',fig);
end
hold(ax,'on');  grid(ax,'on')
% ---任意のプロット---
p_each = plot(ax,abs(z));
p_mean = plot(ax,mean(abs(z),2),'r','DisplayName','平均');
p_line = yline(ax,mean(abs(z),"all"),'k','DisplayName','全平均');
xlabel(ax, "row no.");  xlim(ax,[1,8])
ylabel(ax, "abs(z)");   ylim(ax,[0,2])
title("TITLE")
legend(ax,[p_mean, p_line])% 平均, 全平均にのみlabel付加   
% plot時にDisplayNameを明示しない代わりにlegend(ax,[p_mean, p_line],{'平均', '全平均'})でも可
% ---END---
hold(ax,'off')
fig = gcf;
if ~isempty(savepath);  saveas(gcf, savepath);  end     % 保存

% figure,axの描画・保存後の扱い
switch dstrct
    case 'keep'         % 何もしない
    case 'closeaxes';   cla;
    case 'clearfigure'; clf;
    case 'closefigure'; close(fig)
end

end
