/*
 * Licensed to the Apache Software Foundation (ASF) under one
 * or more contributor license agreements.  See the NOTICE file
 * distributed with this work for additional information
 * regarding copyright ownership.  The ASF licenses this file
 * to you under the Apache License, Version 2.0 (the
 * "License"); you may not use this file except in compliance
 * with the License.  You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package org.apache.paimon.web.server.data.model;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;

import javax.validation.constraints.Max;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotBlank;

import java.time.LocalDateTime;

/** Cluster table model. */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
@EqualsAndHashCode(callSuper = true)
@TableName("cluster")
public class ClusterInfo extends BaseModel {

    private static final long serialVersionUID = 1L;

    @NotBlank(message = "invalid.clusterName")
    private String clusterName;

    @NotBlank(message = "invalid.host")
    private String host;

    @Min(value = 1, message = "invalid.min.port")
    @Max(value = 65535, message = "invalid.max.port")
    private Integer port;

    @NotBlank(message = "invalid.clusterType")
    private String type;

    private String deploymentMode;

    private Boolean enabled;

    private String heartbeatStatus;

    private LocalDateTime lastHeartbeat;
}
