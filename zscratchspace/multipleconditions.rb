Request.pending.where(
					'(approver1_id= ? AND state_id= ?) 
					OR 
					(approver2_id= ? AND state_id= ?) 
					OR 
					(approver3_id= ? AND state_id= ?)'
					, current_user.id, 1
					, current_user.id, 2
					, current_user.id, 3)



Comment.where(:created_at => time_range).where("user_id is not in (?)",[user_ids])


