classdef Combinedd
    properties
        out_s_in_s_in
        out_s_in_a_in
        out_a_in_a_in
        out_a_in_a_o1
        out_a_in_a_o2
        out_a_o1_a_o1
        out_a_o1_a_o2
        out_a_o1_s_ou
        out_a_o2_a_o2
        out_a_o2_s_ou
        out_s_ou_s_ou
         
         theta_sprial_in
         theta_sprial_out  % 与theta_sprial_in
         theta_reverse
         theta_change_arc

    end


    methods
        function obj = setFunction(obj, ...
                out_s_in_s_in_, ...
                out_s_in_a_in_, ...
                out_a_in_a_in_, ...
                out_a_in_a_o1_, ...
                out_a_in_a_o2_, ...
                out_a_o1_a_o1_, ...
                out_a_o1_a_o2_, ...
                out_a_o1_s_ou_, ...
                out_a_o2_a_o2_, ...
                out_a_o2_s_ou_, ...
                out_s_ou_s_ou_)
            obj.out_s_in_s_in = out_s_in_s_in_;
            obj.out_s_in_a_in = out_s_in_a_in_;
            obj.out_a_in_a_in = out_a_in_a_in_;
            obj.out_a_in_a_o1 = out_a_in_a_o1_;
            obj.out_a_in_a_o2 = out_a_in_a_o2_;
            obj.out_a_o1_a_o1 = out_a_o1_a_o1_;
            obj.out_a_o1_a_o2 = out_a_o1_a_o2_;
            obj.out_a_o1_s_ou = out_a_o1_s_ou_;
            obj.out_a_o2_a_o2 = out_a_o2_a_o2_;
            obj.out_a_o2_s_ou = out_a_o2_s_ou_;
            obj.out_s_ou_s_ou = out_s_ou_s_ou_;
            
            


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
        
        function out = evaluate(obj, thetaip1,thetai)
            thetaip1_real = obj.getRealTheta(thetaip1);
            thetai_real = obj.getRealTheta(thetai);
            if thetaip1 > obj.theta_sprial_in && thetai > obj.theta_sprial_in
                out = obj.out_s_in_s_in(thetaip1_real, thetai_real);
            elseif thetaip1 >= obj.theta_sprial_in && obj.theta_sprial_in >= thetai && thetai > obj.theta_change_arc
                out = obj.out_s_in_a_in(thetaip1_real, thetai_real);
            elseif obj.theta_sprial_in >= thetaip1 && thetaip1 > obj.theta_change_arc && obj.theta_sprial_in >= thetai && thetai > obj.theta_change_arc
                out = obj.out_a_in_a_in(thetaip1_real, thetai_real);
            elseif obj.theta_sprial_in >= thetaip1 && thetaip1 > obj.theta_change_arc && obj.theta_change_arc >= thetai && thetai > obj.theta_reverse
                out = obj.out_a_in_a_o1(thetaip1_real, thetai_real);
            elseif obj.theta_sprial_in >= thetaip1 && thetaip1 > obj.theta_change_arc && obj.theta_reverse >= thetai && thetai > obj.theta_sprial_out
                out = obj.out_a_in_a_o2(thetaip1_real, thetai_real);
            elseif obj.theta_change_arc >= thetaip1 && thetaip1 > obj.theta_reverse && obj.theta_change_arc >= thetai && thetai > obj.theta_reverse
                out = obj.out_a_o1_a_o1(thetaip1_real, thetai_real);
            elseif obj.theta_change_arc >= thetaip1 && thetaip1 > obj.theta_reverse && obj.theta_reverse >= thetai && thetai > obj.theta_sprial_out
                out = obj.out_a_o1_a_o2(thetaip1_real, thetai_real);
            elseif obj.theta_change_arc >= thetaip1 && thetaip1 > obj.theta_reverse && obj.theta_reverse >= thetai
                out = obj.out_a_o1_s_ou(thetaip1_real, thetai_real);
            elseif obj.theta_reverse >= thetaip1 && thetaip1 > obj.theta_sprial_out && obj.theta_reverse >= thetai && thetai > obj.theta_sprial_out
                out = obj.out_a_o2_a_o2(thetaip1_real, thetai_real);
            elseif obj.theta_reverse>= thetaip1 && thetaip1 > obj.theta_sprial_out && obj.theta_reverse >= thetai
                out = obj.out_a_o2_s_ou(thetaip1_real, thetai_real);
            elseif obj.theta_sprial_out >= thetaip1  && obj.theta_sprial_out >= thetai
                out = obj.out_s_ou_s_ou(thetaip1_real, thetai_real);
            
            else
                disp('输入 theta 不在范围内');
                disp(thetaip1);
                disp( thetai);
            end
        end
    end
end


