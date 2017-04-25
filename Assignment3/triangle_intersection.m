function flag = triangle_intersection(P1, P2)
% triangle_test : returns true if the triangles overlap and false otherwise

% P1, P2: a 3 by 2 array (each), describing the vertices of a triangle,
% the first column corresponds to the x coordinates while the second column
% corresponds to the y coordinates

    function flag = sameside(p1,p2,a,b)
        % sameside : returns true if the p1,p1 lie on same sides of the
        % edge ab and false otherwise

        x_1=a(1);
        y_1=a(2);
        x_2=b(1);
        y_2=b(2);
        x_3=p1(1);
        y_3=p1(2);
        x_4=p2(1);
        y_4=p2(2);
        
        valx=det([x_1 y_1 1;x_2 y_2 1;x_3 y_3 1]);
        valy=det([x_1 y_1 1;x_2 y_2 1;x_4 y_4 1]);
        %valx=(x_3 - x_1) * (y_2 - y_1) - (x_2 - x_1) * (y_3 - y_1);
        %valy=(x_4 - x_1) * (y_2 - y_1) - (x_2 - x_1) * (y_4 - y_1);
        if(valx*valy > 0)
            flag = true;
        else
            flag = false;
        end
    end

% Repeat the vertices for the loop
P1(4:5,:) = P1(1:2,:);
P2(4:5,:) = P2(1:2,:);
flag = true;

% Testing all the edges of P1
for i=1:3
    if(~sameside(P1(i,:), P2(1,:), P1(i+1,:), P1(i+2,:)) ...
            && sameside(P2(1,:), P2(2,:), P1(i+1,:), P1(i+2,:)) ...
            && sameside(P2(2,:), P2(3,:), P1(i+1,:), P1(i+2,:)))
        flag = false; return;
    end
end

% Testing all the edges of P2
for i=1:3
    if(~sameside(P2(i,:), P1(1,:), P2(i+1,:), P2(i+2,:)) ...
            && sameside(P1(1,:), P1(2,:), P2(i+1,:), P2(i+2,:)) ...
            && sameside(P1(2,:), P1(3,:), P2(i+1,:), P2(i+2,:)))
        flag = false; return;
    end
end

end