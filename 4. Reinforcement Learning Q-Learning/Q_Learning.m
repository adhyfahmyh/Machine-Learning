
function [current] = Q_Learning(reward, Q)
%set gamma dari 0-1
gam = 0.8
%goal baris ke 91 pada tabel reward
%% perulangan for 
%1-100 dr tabel reward
%pengecekan (episode) dilakukan perbaris
for i=1:100
    rx = randi(100)
    current = rx
    next = 0
    done = 1
    %% perulangan while 
    %ketika goal belum tercapai
    while (done~=0)
        if next==91
            done = 0
        else
            done = 1
        end
        
        %% perhitungan posssible action (arah)
        %arah = 1 = atas
        %arah = 2 = bawah
        %arah = 3 = kiri
        %arah = 4 = kanan
        arah = randi(4)
        if reward(current,arah)==0
            arah = randi(4)
        else
            if arah == 1
                next = current-1
            elseif arah == 2
                next = current+1
            elseif arah == 3
                next = current-10
            elseif arah == 4
                next = current+10
            end
            
            a = 1
            while(a~=4)
                if  reward(next,a)==0
                    a = a + 1
                else
                    cek(1,a) = Q(next,a)
                    a = a + 1
                end
            end
            %perhitungan formula Q-Learning untuk update tabel Q yang
            %sebelumnya di set 0
            Q(current,arah) = reward(current,arah) + gam * max(cek)
            %possible action dijadikan current state
            current = next
        end
    end
end

total_reward = sum(cek)