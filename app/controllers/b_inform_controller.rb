# coding: utf-8
class BInformController < ApplicationController
    def toukou
      #セッション情報からアカウント情報識別

      #募集をDBに登録
      re_id_=tmp_id=params[:re_id]
      bosyuu_=tmp_h=params[:ht2]
      title_=tmp_title=params[:title_]

      if tmp_id.size==0 #re_idがNULLの場合通常発言
        re_id_=nil
      end
      if tmp_title.size==0 #re_idがNULLの場合通常発言
        title_=nil
      end

      if tmp_h.size ==0 || (tmp_h.gsub(/\r\n|\r|\n|\s|\t/, "")).size==0
        bosyuu_=nil
      end
      Recruitment.create(detail:bosyuu_,re_id:re_id_ ,acc_id:"bbb",title:title_)
      Recruitment.where(detail:nil,re_id:nil).destroy_all
      Recruitment.where(title:none).destroy_all
    end

  end

