drop table if exists woocommerce_order_itemmeta;
drop table if exists woocommerce_order_items;
drop table if exists postmeta;
drop table if exists posts;

create table posts as (select * from wp_posts where post_type='shop_order' and id >= 50133);
create table postmeta as (select * from wp_postmeta where post_id in (select id from posts));
create table woocommerce_order_items as (select * from wp_woocommerce_order_items where order_id in (select id from posts));
create table woocommerce_order_itemmeta as (select * from wp_woocommerce_order_itemmeta where order_item_id in (select order_item_id from woocommerce_order_items));
alter table posts add primary key (id);
alter table postmeta add primary key (meta_id);
alter table postmeta add index post_id_index (post_id);
alter table postmeta add constraint post_id_fk foreign key (post_id) references posts (id) on delete cascade on update cascade;
alter table woocommerce_order_items add primary key (order_item_id);
alter table woocommerce_order_items add index order_id_index (order_id);
alter table woocommerce_order_items add constraint order_id_fk foreign key (order_id) references posts (id) on delete cascade on update cascade;
alter table woocommerce_order_itemmeta add primary key (meta_id);
alter table woocommerce_order_itemmeta add index order_item_id_index (order_item_id);
alter table woocommerce_order_itemmeta add constraint order_item_id_fk foreign key (order_item_id) references woocommerce_order_items (order_item_id) on delete cascade on update cascade;

set @nextpostid=1000000;
set @nextmetaid=1000000;
set @nextorderitemid=1000000;
set @nextorderitemmetaid=1000000;

update posts set id=(@nextpostid:=@nextpostid+1);
update postmeta set meta_id=(@nextmetaid:=@nextmetaid+1);
update woocommerce_order_items set order_item_id=(@nextorderitemid:=@nextorderitemid+1);
update woocommerce_order_itemmeta set meta_id=(@nextorderitemmetaid:=@nextorderitemmetaid+1);

set @nextpostid=(select id+1 from yourwoodb.wp_posts order by id desc limit 1);
set @nextmetaid=(select meta_id+1 from yourwoodb.wp_postmeta order by meta_id desc limit 1);
set @nextorderitemid=(select order_item_id+1 from yourwoodb.wp_woocommerce_order_items order by order_item_id desc limit 1);
set @nextorderitemmetaid=(select meta_id+1 from yourwoodb.wp_woocommerce_order_itemmeta order by meta_id desc limit 1);

update posts set id=(@nextpostid:=@nextpostid+1);
update postmeta set meta_id=(@nextmetaid:=@nextmetaid+1);
update woocommerce_order_items set order_item_id=(@nextorderitemid:=@nextorderitemid+1);
update woocommerce_order_itemmeta set meta_id=(@nextorderitemmetaid:=@nextorderitemmetaid+1);

insert into yourwoodb.wp_posts select * from posts;
insert into yourwoodb.wp_postmeta select * from postmeta;
insert into yourwoodb.wp_woocommerce_order_items select * from woocommerce_order_items;
insert into yourwoodb.wp_woocommerce_order_itemmeta select * from woocommerce_order_itemmeta;

set @lastcustomerid = (select customer_id from yourwoodb.wp_wc_customer_lookup order by customer_id desc limit 1);
insert into yourwoodb.wp_wc_customer_lookup select * from wp_wc_customer_lookup where customer_id > @lastcustomerid;
