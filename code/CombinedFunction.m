classdef CombinedFunction
    properties
         out_sprial_in
         out_sprial_out
         out_arc_in
         out_arc_out1
         out_arc_out2
         
         theta_sprial_in
         theta_sprial_out  % 与theta_sprial_in
         theta_reverse
         theta_change_arc

    end

    methods
        function obj = setFunction(obj,out_sprial_in_,out_sprial_out_,out_arc_in_,out_arc_out1_,out_arc_out2_)
         obj.out_sprial_in = out_sprial_in_;
         obj.out_sprial_out = out_sprial_out_;
         obj.out_arc_in = out_arc_in_; % +
         obj.out_arc_out1 = out_arc_out1_; % -
         obj.out_arc_out2 = out_arc_out2_; % +
        end

        function obj = setThreshold(obj,theta_sprial_in_, theta_sprial_out_, theta_reverse_, theta_change_arc_)
        obj.theta_sprial_in = theta_sprial_in_;
        obj.theta_sprial_out = theta_sprial_out_;
        obj.theta_reverse = theta_reverse_;
        obj.theta_change_arc = theta_change_arc_;

        end

        function theta_real = getRealTheta(obj,theta_natural)
            % if theta_natural > obj.theta_reverse
            %     theta_real = theta_natural;
            % else
            %     theta_real = 2*obj.theta_reverse - theta_natural;
            % end
            theta_real = obj.theta_reverse + abs(theta_natural-obj.theta_reverse);
        end
        
        function out = evaluate(obj, theta_natural)
            if theta_natural > obj.theta_sprial_in
                out = obj.out_sprial_in(theta_natural);
                %disp(1)
            elseif theta_natural > obj.theta_change_arc
                out = obj.out_arc_in(theta_natural);
                %disp(2)
            elseif theta_natural >= obj.theta_reverse
                out = obj.out_arc_out1(theta_natural);
                %disp(3)
            elseif theta_natural > obj.theta_sprial_out
                %disp(4)
                theta_real = obj.getRealTheta(theta_natural);
                out = obj.out_arc_out2(theta_real);
            else
                %disp(5)
                theta_real = obj.getRealTheta(theta_natural);
                out = obj.out_sprial_out(theta_real);
            % if isreal(out) ==false
            %     out = double(out);
            % end
            end
        end
    end
end