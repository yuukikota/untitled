class UnivtagController < ApplicationController
  def list
    list = []
    if params.has_key?(:school) && params.has_key?(:faculty) && params.has_key?(:type) then
      if params[:type] == "0" then #大学取得
        list = Univinfo.where(stat: 0).pluck(:name)
      elsif params[:type] == "1" then  #学部取得
        if params[:school] != "" then
          univ = Univinfo.find_by(name: params[:school])
          if univ.present? then
            list = Univinfo.where(p_id: univ.id).pluck(:name)
          end
        else
          list = Univinfo.where(stat: 1).distinct.pluck(:name)#すべての学部
        end
      elsif params[:type] == "2" then #学科取得
        if params[:faculty] != "" then
          univ = Univinfo.find_by(name: params[:school])
          if univ.present? then
            faculty = Univinfo.find_by(name: params[:faculty], p_id: univ.id)
            if faculty.present? then
              list = Univinfo.where(p_id: faculty.id).pluck(:name)
            end
          end
        else
          list = Univinfo.where(stat: 2).distinct.pluck(:name)#すべての学科
        end
      end
    end
    render json: list
  end

end
