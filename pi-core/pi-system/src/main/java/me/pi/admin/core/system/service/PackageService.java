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
import com.baomidou.mybatisplus.extension.service.IService;
import me.pi.admin.core.system.pojo.dto.PackageDTO;
import me.pi.admin.core.system.pojo.po.SysPackage;
import me.pi.admin.core.system.pojo.query.PackageQuery;
import me.pi.admin.core.system.pojo.vo.PackageVO;

import java.util.Collection;

/**
 * 针对表【sys_package】的数据库操作 Service
 *
 * @author ZnPi
 * @date 2023-05-22
 */
public interface PackageService extends IService<SysPackage> {
    /**
     * 获取套餐
     *
     * @param query 查询参数
     * @return 套餐列表
     */
    IPage<PackageVO> getPackages(PackageQuery query);

    /**
     * 新增或编辑
     *
     * @param dto PackageDTO
     */
    void saveOrUpdate(PackageDTO dto);

    /**
     * 删除
     *
     * @param ids 待删除记录 ID 列表
     */
    void delete(Collection<Long> ids);

    /**
     * 套餐是否存在
     * @param packageId 套餐主键
     * @return true: 存在，false: 不存在
     */
    Boolean isExists(Long packageId);
}
