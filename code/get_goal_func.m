classdef get_goal_func
    properties
            AfterPoint
            getvs
    end

    methods
        function obj = setFunction(obj,afterpoint,getthevs)
            obj.AfterPoint = afterpoint;
            obj.getvs = getthevs;
        end
        function out = evaluate(obj, thetas)
            all_points = obj.AfterPoint(thetas);
            out = max(obj.getvs(all_points),[],"all");

        end


    end
end
