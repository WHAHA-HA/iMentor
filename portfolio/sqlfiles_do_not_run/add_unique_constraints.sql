alter table portfolio_reflection_user_details add constraint composite_portfolio_reflection_user_details unique(user_id,reflection_card_id);
alter table portfolio_reflection_user_response add constraint composite_portfolio_reflection_user_response unique(user_id,reflection_user_details_id);

