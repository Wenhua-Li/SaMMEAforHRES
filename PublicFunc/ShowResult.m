%% »­Í¼
close all
n_pic = min(length(Arc),16);
rows = ceil(n_pic^0.5);
cols = ceil(n_pic/rows);
for i=1:n_pic
    path = Arc(i).decs;
    
    subplot(rows,cols,i)
    [x,y]=find(Map==0);
    plot(x,y,'k.')
    hold on
    plot(START_x,START_y,'go','MarkerFaceColor','g')
    plot(GOAL_x,GOAL_y,'go','MarkerFaceColor','g')
    
    if problem_id <=5
        plot(Red_areas(:,1),Red_areas(:,2),'ro')
    end
    if problem_id >= 11
        plot(Yellow_areas(:,1),Yellow_areas(:,2),'o','markerfacecolor','y')
    end
    
    for j=1:numel(path)-1
        cur_point_xy = turn_point(path(j),:);
        next_point_xy = turn_point(path(j+1),:);
        line([cur_point_xy(1),next_point_xy(1)],[cur_point_xy(2),next_point_xy(2)],'color','r','linewidth',2)
    end
    axis equal
    str='Objs: [';
    for f=1:size(Arc(i).objs,1)
        str = [str num2str(Arc(i).objs(f)) ','];
    end
    title([str ']'])
end
set(gcf,'outerposition',get(0,'screensize'));