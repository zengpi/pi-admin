/*
 * Copyright 2022-2023 ZnPi
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package me.pi.admin.core.system.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import me.pi.admin.common.mybatis.BaseQuery;
import me.pi.admin.core.system.pojo.dto.EnterpriseDTO;
import me.pi.admin.core.system.pojo.po.SysEnterprise;
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.core.system.pojo.vo.EnterpriseVO;

import java.util.Collection;

/**
 * 针对表【sys_enterprise】的数据库操作 Service
 *
 * @author ZnPi
 * @date 2023-05-19
 */
public interface EnterpriseService extends IService<SysEnterprise> {
    /**
     * 查询企业
     *
     * @param query 查询参数
     * @return 企业列表
     */
    IPage<EnterpriseVO> getEnterprises(BaseQuery query);

    /**
     * 新增或编辑
     *
     * @param dto EnterpriseDTO
     */
    void saveOrUpdate(EnterpriseDTO dto);

    /**
     * 删除
     *
     * @param ids 待删除记录 ID 列表
     */
    void delete(Collection<Long> ids);
}
